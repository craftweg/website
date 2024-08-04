---
title: "Continuous releases with automated changelog generation"
description: "Automate the continuous release of releasable changes with git-cliff and CI."
tags: ["Open Source", "Tuist"]
---

As part of our work on [Tuist](https://tuist.io),
we open source small pieces of technology that aim to commoditize the development of Swift tools.
An example of that is [XcodeProj](https://github.com/tuist/xcodeproj).
Because those projects are not actively worked on,
it was important to have a process that would automate the release of new versions when releasable changes were merged.

To achieve that, I used a tool that I discovered recently through [Mise](https://mise.jdx.dev/), [git-cliff](https://git-cliff.org/), which automates the generation of changelogs based on the repository's local and remote history (e.g., GitHub pull requests). Once the tool is installed, something that you can achieve easily with Mise:

```language-toml
[tools]
"git-cliff" = "2.4.0"
```

You can initialize it by running:

```language-bash
git cliff --init github
```

The argument `github` instructs the initialization command to use the vendored GitHub template. You can check out [this list](https://git-cliff.org/docs/usage/initializing) of other templates. The command generates a `cliff.` `toml` with a default configuration, which in my case I left as is.

## The workflow

We use GitHub Actions, so the first thing we'll need in the release workflow at `.github/workflows/release.yml` is the configuration to run for every commit in the `main` branch:

```language-yaml
on:
  push:
    branches:
      - main
```

As one of the first steps after checking out the repository, we'll need to check whether a release is necessary. We can do that by comparing the persisted `CHANGELOG.md`, which I had previously generated with `git cliff -o CHANGELOG.md`, and the one that would be generated with the bumped version, which I can obtain with `git cliff --bump`:

```language-yaml
- name: Check if there are releasable changes
  id: is-releasable
  run: |
    bumped_output=$(git cliff --bump)
    changelog_content=$(cat CHANGELOG.md)
    if [ "${bumped_output}" = "${changelog_content}" ]; then
      echo "should-release=false" >> $GITHUB_ENV
    else
      echo "should-release=true" >> $GITHUB_ENV
    fi
```

Note that I set `git.filter_unconventional = true` to only consider releasable those commits that follow the conventional commit format.

From there, we can obtain the next version (note that we skip if we shouldn't release):

```language-yaml
- name: Get next version
  id: next-version
  if: env.should-release == 'true'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: echo "NEXT_VERSION=$(git cliff --bumped-version)" >> "$GITHUB_OUTPUT"
```

And the release notes:

```language-yaml
- name: Get release notes
  id: release-notes
  if: env.should-release == 'true'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: |
    echo "RELEASE_NOTES<<EOF" >> "$GITHUB_OUTPUT"
    git cliff --unreleased >> "$GITHUB_OUTPUT"
    echo "EOF" >> "$GITHUB_OUTPUT"
```

The remaining steps are just updating the `CHANGELOG.md`, committing the changes tagged with the version, pushing the changes upstream, and creating a release on GitHub.

```language-yaml
- name: Update CHANGELOG.md
  if: env.should-release == 'true'
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: git cliff --bump -o CHANGELOG.md
- name: Commit changes
  id: auto-commit-action
  uses: stefanzweifel/git-auto-commit-action@v5
  if: env.should-release == 'true'
  with:
    commit_options: '--allow-empty'
    tagging_message: ${{ steps.next-version.outputs.NEXT_VERSION }}
    skip_dirty_check: true
    commit_message: "[Release] Command ${{ steps.next-version.outputs.NEXT_VERSION }}"
- name: Create GitHub Release
  uses: softprops/action-gh-release@v2
  if: env.should-release == 'true'
  with:
    draft: false
    repository: tuist/Command
    name: ${{ steps.next-version.outputs.NEXT_VERSION }}
    tag_name: ${{ steps.next-version.outputs.NEXT_VERSION }}
    body: ${{ steps.changelog.outputs.CHANGELOG }}
    target_commitish: ${{ steps.auto-commit-action.outputs.commit_hash }}
```

I'm quite happy with the result, which you can check out completely [in this file](https://github.com/tuist/Command/blob/main/.github/workflows/command.yml).
