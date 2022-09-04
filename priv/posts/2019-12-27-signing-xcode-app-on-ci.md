---
title: Signing with Xcode on CI
categories: [xcode, swift, signing, macos]
---

Today,
I worked on automating the release process of [Angle](https://angle.dev) on CI.
At first,
I thought it'd be a straightforward task,
but it turned out not to be so.
Most Xcode projects don't have to deal with this because they use [Match](https://fastlane.tools),
which abstracts us from all those intricacies,
but Angle doesn't use Match to keep the tooling stack as lean as possible.

For those of you who run into this need in the future, this is the TL;DR; version of what needs to be done:

1. Create an **unlocked** keychain where signing certificates will be imported.
   If we use the system one,
   the OS will prompt the user to confirm the access,
   and since there's no user interface on CI,
   the build will get stuck.
2. **Import the certificates** and their private keys into the Keychain created in the previous step.
3. Allow `codesign`,
   the signing tool from Xcode,
   to access the certificates without prompting the user for the password.
4. **Copy the provisioning profiles** into the directory where Xcode reads them from.
5. Run **xcodebuild** using the `OTHER_CODE_SIGN_FLAGS` build setting to indicate the certificate that should be used to read the certificates from.

Since we are using [Ruby](https://www.ruby-lang.org/en/) and [Rake](https://github.com/ruby/rake) for automation in the project,
in the following sections I include some Ruby snippets that I extracted from the project.

#### Executing commands in the system

The method below wraps the execution of system commands using Ruby's `system` method and adding support for printing the command that is executed:

```ruby
def execute(print_command: false)
  puts("Running: #{args.join(" ")}") if print_command
  system(*args) || abort
end
```

#### Creating the Keychain

The snippet below includes a method to initialize a temporary keychain where we'll import the signing certificates.
Note that that after creating the Keychain,
we use `set-keychain-settings` to set the timeout until which the keychain will remain unlocked; 1 hour in our case.
Moreover,
we unlock the keychain so that processes can access it without the os prompting the user for the password.
The `set_key_partition_list` function configures the keychain to give Apple's tools access to the keychain:

```rb
def with_keychain
  keychain_name = "ci.keychain"
  keychain_password = "ci"

  puts("Creating Keychain for signing")
  execute("security", "create-keychain", "-p", keychain_password, keychain_name)
  execute("security", "list-keychains", "-s", keychain_name)
  execute("security", "set-keychain-settings", "-t", "3600", "-u", keychain_name)
  execute("security", "unlock-keychain", "-p", keychain_password, keychain_name)

  set_key_partition_list = ->() {
    execute("security", "set-key-partition-list", "-S", "apple-tool:,apple:,codesign:", "-s", "-k", keychain_password, keychain_name)
  }

  yield(keychain, set_key_partition_list)
ensure
  execute("security", "delete-keychain", keychain_name)
end
```

> Note that we **ensure** that the temporary keychain is deleted once the given block finishes executing.

#### Installing certificates and profiles

Once we have the keychain created,
we can proceed with installing the certificates.
We can do that by using the `security import` command.
As we can note in the code snippet below,
we need to use the `-T` argument to indicate which executables will have access to the certificate.

In the case of provisioning profiles,
we need to copy them to `~/Library/MobileDevice/Provisioning Profies`,
the directory where Xcode reads them from.

The snippet below iterates through all the certificates and profiles under the `certificates/` directories,
installing and copying the certificates and provisioning profiles respectively:

```rb
def install_certificates(keychain: nil)
  puts("🔑 Installing certificates and copying provisioning profiles")
  files = Dir.glob(File.join(__dir__, "certificates/*"))
  files.each do |file|
    if file.include?(".p12") || file.include?(".cer")
      security_import_command = [
        "security", "import",
        file,
        "-P", "",
        "-T", "/usr/bin/codesign",
        "-T", "/usr/bin/security",
      ]
      security_import_command.concat(["-k", keychain]) unless keychain.nil?
      execute(*security_import_command)
    elsif file.include?(".provisionprofile")
      profiles_path = File.expand_path("~/Library/MobileDevice/Provisioning\ Profiles")
      copy_to_path = File.join(profiles_path, File.basename(file))
      FileUtils.mkdir_p(File.dirname(copy_to_path))
      FileUtils.cp(file, copy_to_path)
    end
  end
end
```

#### Archiving & exporting the app

Once we have the temporary keychain with the right content in it,
it's time to archive and export the app.
Remember,
archive generates a `.xcarchive` file that we need to export and sign obtaining a `.app` as a result.

For **archiving** the app we run `xcodebuild` passing the configuration,
the path where we'd like to export the `.xcarchive` file,
as well as the `OTHER_CODE_SIGN_FLAGS` build setting with the value `--keychain keychain_name`.
That way we can indicate Xcode to use a keychain other than the default one.

**Exporting** is very similar,
with the difference that we need to pass the `-exportPath` to indicate the path where the app should be exported,
as well as `-exportOptionsPlist` pointing to a `.plist` file with options to export the app.

```ruby
def archive_and_export(keychain: nil)
  puts("📦 Archiving app")
  archive(keychain: keychain) do |archive_path|

    puts("👩‍💻 Exporting app")
    export(archive_path: archive_path, keychain: keychain) do |app_path|
      yield(app_path)
    end
  end
end

def archive(keychain: nil)
  Dir.mktmpdir do |dir|
    archive_path = File.join(dir, "Project.xcarchive")
    arguments = [
      "-configuration", "Release",
      "-archivePath", archive_path,
      "clean",
      "archive"
    ]
    arguments << "OTHER_CODE_SIGN_FLAGS='--keychain #{keychain}'" unless keychain.nil?
    xcodebuild(*arguments)
    yield(archive_path)
  end
end

def export(archive_path:, keychain: nil)
  Dir.mktmpdir do |dir|
    export_options_path = File.join(dir, "options.plist")
    File.write(export_options_path, export_options)

    arguments = [
      "-exportArchive",
      "-exportOptionsPlist", export_options_path,
      "-archivePath", archive_path,
      "-exportPath", dir,
      "MACOSX_DEPLOYMENT_TARGET=#{MACOSX_DEPLOYMENT_TARGET}",
    ]
    arguments << "OTHER_CODE_SIGN_FLAGS='--keychain #{keychain}'" unless keychain.nil?

    xcodebuild(
      *arguments,
      project: nil,
      scheme: nil
    )

    app_path = Dir.glob(File.join(dir, "*.app")).first
    yield(app_path)
  end
end
```

## Putting it all together

And combining all the previous snippets,
the resulting code looks like the snippet below. Beautiful, _isn't it?_

```rb
with_keychain do |keychain|
  install_certificates(keychain: keychain) do
    set_key_partition_list.call

    archive_and_export(keychain: keychain)
  end
end
```

## Some final notes

The part that took me the most time to figure out was giving `xcodebuild` and [Sparkle](https://sparkle-project.org/) access to the keychain without the os prompting for the password.
Initially,
I thought it was enough with unlocking the keychain,
but I was wrong in that assumption.
When adding items to the keychain,
we need to use the `-T` argument to indicate the applications that have access to the item.
Moreover,
we also need to use `set-key-partition-list` command from `security`, which sets the `PartitionIDs` for keys that can sign _(-s)_ for a specific keychain.
