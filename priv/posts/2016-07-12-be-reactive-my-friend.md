---
title: Be Reactive my friend
description: Article that explains the benefits of reactive programming in the iOS world.
tags: [github, scrum, issues, zenhub, management, project]
---

In a world where data comes from everywhere being reactive when coding your apps could make a huge difference in the user experience. Even though Reactive is becoming more popular across the community the benefits are not clear enough. Entities can trigger events from many places around the app. It can be either from an user action, an application lifecycle or a push notification. These triggers turn into some state changes that our app has to reflect somehow. Some examples could be:

- Opening a detail view when a push notification is received.
  - **Push Notification into Navigation State Change**
- View reload due to a sync of data in background.
  - **Data Refresh into a Collection View Reload**
- Events from a player, for example new track.
  - **User action into a Player Controls Update**

When our code is imperative, we notify the interested entities manually. How many of you have written pieces of code like these in your apps:

```language-swift
// Synchronizing data
apiClient.synchronizeTracks { [weak self] tracks in
  self?.tracks = tracks
  self?.tableView.reloadData()
}

// Player
func loadTrack(track: Track) {
  self.player.instance.loadTrack(track)
  self.playerControls.updateWithTrack(track)
}
```

Entities change the state in our **sources of truth** from many points _(e.g. tracks in a `database` or current track in the `player`)_. Think about a player that is playing tracks in background. The player controls are floating in the UI and the user opens a track from a new view controller. _What if the developer forgets about updating the controls?_ Or think about a predictive data sync. For example, we sync the notifications when a push notification is received. How would you update the collection view if you don't know about the notifications view controller from the AppDelegate? (and no... appealing to singletons or inspection is not a good solution).

There’s a clear need to be reactive, react to the things that are happening in your app, no matter who’s triggering them and from where. Being reactive doesn’t mean add one of these reactive libraries in your project as a pod and use it. But design your application to be Reactive. These libraries will help you making things easier and nicer.

> Being **reactive** is about designing your app to react to changes. It requires some effort to set your mindset away from the imperative world.

I’ll guide you in this post through some common scenarios and explain how to separate the action _triggering_ from the _reaction_.

## Databases and data synchronization

![Reactive database](/images/posts/reactive-database.png)

#### Scenario

Databases are sources of truth in our apps. They save the data, in most of cases coming from an external _API_. Since apps want to offer the best user experience, they get sync with the API as the user navigates through the app. `viewDidLoad()` is the common place where most of developers trigger the data sync. However, there are more places where the data can be sync. Those apps that sync the data predictively do it from places such as background operations or push notifications.

In these cases it’s important that any entity in the app **interested** in that data, gets notified when these syncs take place.

#### Example

When the `StreamViewController` is loaded we ask for data synchronization. This event doesn't report anything but it could return an error if we're interested in presenting an alert in that case. When the data is updated in the database we'll be observing it and updating the collection view presenting that new data that has been inserted.

```language-swift
class StreamViewController: UIViewController {
  func viewDidLoad() {
    super.viewDidLoad()
    self.synchronizeStream()
    self.observeStreamTracks()
  }

  func synchronizeStream() {
   // Synchronization logic
  }

  func observeStreamTracks() {
    //TODO
  }
}
```

#### Implementation

- If you're using `Realm`/`CoreData` you can use [SugarRecord](https://github.com/pepicrft/sugarrecord) that provides a `StorageObservable` object.
- There's a Realm reactive extension for RxSwift, [RxRealm](https://github.com/RxSwiftCommunity/RxRealm) that supports notifications.

## Keychain and user login/logout

![Reactive keychain](/images/posts/reactive-keychain.png)

#### Scenario

If we support authentication in our apps we might be saving user's credentials in Keychain. Login is done from the login view and the logout most likely from an account/settings view. When login/logout take place in the app there are some entities that might be interested about session changes in the Keychain, for example, your app navigation and your http client:

- When the user signs in, you might want to reset the application `rootViewController` and create the new views hierarchy for authenticated users. The same with the signout.
- If you have a http client that holds the user session state you might need resetting the token from that client instance, otherwise you'll be sending requests with the wrong authentication state.

#### Example

We subscribe in the `AppDelegate` to session changes. Since we're only interested in the transition between states, we use the operator `distinctUntilChanged`. When there's a new `.Next(Session?)` event sent we update the root view controller according to that.

```language-swift
class AppDelegate {

  func observeUserSession() {
     let sessionObserver = SessionObserver(name: "my-service")
     sessionObserver
      .map { $0 != nil }
      .distinctUntilChanged()
      .subscribeNext { [weak self] authenticated in
        if authenticated {
          self?.showLogin()
        } else {
          self?.showApp()
        }
      }
  }
}
```

#### Implementation

Keychain is not KVO compliant so we cannot subscribe to changes at a given keypath. _How can we observe it then?_ You have to proxy the access to the Keychain registering observers there. Whenever the Keychain is accessed through this proxy all the observers are notified if they are concerned about the updated keychain element.
It's very important that the access to the keychain is always done via that proxy class, otherwise your observers wouldn't get notifications when the state changes in the Keychain.

The interface would look like this one:

```language-swift
class KeychainRepository {
  static let instance: KeychainRepository = KeychainRepository()
  func save(session session: Session, name: String)
  func clear(name name: String)
  func fetch(name name: String) -> Session?
  func observe(name name: String) -> Observable<Session?>
}
```

## UserDefaults and local states

#### Scenario

There's some data that is not persisted in databases for example the user profile or local configuration that is not sync in the API and that is cleaned up once the user removes the app.

#### Example

```language-swift
func viewDidLoad() {
  super.viewDidLoad()
  self.userObserver = UserObserver()
  self.userObserver.rx().subscribeNext { [weak self] user in
    self.avatarImageView.setImage(url: user.avatarUrl)
  }
}
```

#### Implementation

If we support authentication in our apps we might be saving user’s credentials in Keychain. User signs in from the login view and the logout most likely from an account/settings view. When login/logout take place in the app there are some entities that might be interested about session changes in the Keychain. For example, your app navigation and your http client:

```language-swift
protocol Repository {
  typealias T
  func save(entity entity: T, name: String)
  func clear(name name: String)
  func fetch(name name: String) -> T?
  func observe(name name: String) -> Observable<T?>
}
```

> I did an implementation that is available on this [gist](https://gist.github.com/pepicrft/ba7a1b459634ebf29de0772272b8460b). It defines an `UserDefaultsObservable` that allows you to subscribe to. To keep the subscription alive you must keep a reference to the observable.

# Conclusion

Our apps are full of these scenarios where triggers and observations are completely separated. In that sense reacting to these triggers would prevent us from imperatively looking for the entities that might be interested in these events. We also decouple synchronization from fetching so if we wanted to replace any of those elements, you could easily do it without affecting the other. Moreover, don't think that being reactive is about using reactive concepts and libraries out of there. You can be reactive as well by subscribing to the `NSNotificationCenter` or using a `NSFetchedResultsController`. Libraries such as `RxSwift` and `ReactiveCocoa` provide a typed, more stream based solution, with some operators that allows you combining these events before they reach the subscribers.
