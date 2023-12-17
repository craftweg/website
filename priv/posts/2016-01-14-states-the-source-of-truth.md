---
title: 'States - The source of truth'
description: 'Overview of states in iOS apps, how we tipically handle them, current challenges with states and how to overcome them'
tags: [tvos, popcorn time, torrent]
---

I have been these days thinking about how we do manage states in our iOS apps. States are a source of information but also the source of bugs, why? Because we spread states across multiple components, duplicate them, and we forget about considering derived states. Our app shows off unexpected behaviors, and we struggle to find the reason. The user credentials are persisted in the _Keychain_, so we know whether the user is logged in or not, but our _ApiClient_ also contains that information. Which one should I trust? Are you sure both are synchronizing when any of them changes? I’m sure you miss some. States are a common source of bugs in our apps. There are no silver bullets to solve this problem but multiple approaches out there, programming paradigms, patterns and tricks that can help you with the state simplification.

## Singletons

### An attempt to centralize state

Have you ever wondered why we use singletons for some components in our apps? There are performance reasons, it also provides an instance that can be accessed from any point of your app, and in regard states, it has a reference to a state. The famous _ApiClient.sharedIntance()_ that has information about the access token is a great example. Singletons are great to keep states, as we can access them from anywhere. Nonetheless, we tend to modify its state imperatively without considering that all the consumers of the singleton instance might get into an inconsistent state since they are not subscribed to state changes of the singleton instance.

> Since we don’t subscribe to singleton state changes, we might reach inconsistent states in entities that depend on the singleton state.

![States](/images/posts/states_1.png)

## Flux

### Centralized state with propagation

If you haven’t seen it yet, I recommend you to watch this two talks:

- Unidirectional Data Flow in Swift: An Alternative to Massive View Controllers: [Link](https://realm.io/news/benji-encz-unidirectional-data-flow-swift/)
- Flux — Application Architecture for Building User Interfaces: [Link](https://facebook.github.io/flux/)

I heard about Flux a few days ago when I watch the talk Realm published on their website. Flux is an architecture originally proposed by Facebook that aims unidirectional data flows in apps to build user interfaces. What’s the core idea of Flux?

![States](/images/posts/states_2.png)

- **States are persisted in stores.** You can have multiple stores in your app depending on how many states you want to have. For example, you can have a state that reflects the app navigation state, or another state that reflects the user session in your app. States would be persisted in two respective stores, `NavigationStore`, and `UserSessionStore`.
- **Actions fire state changes:** Actions are the source of state changes as side effects. Actions can be view lifecycle events, user actions, … Whenever something can change the store state, that’s an action. They don’t contain information about how the state will change.
- **State changes are driven by reducers:** Whenever an action is received, it’s passed to all the reducers registered in the store. A reducer is responsible to given the current status and the action that took place, decide the new state of the store. A store can have multiple reducers.
- **States changes are forwarded to subscribers:** When the state of the store changes, it’s notified to multiple subscribers that might be interested in these changes.

There are some frameworks that implement the core concepts of Flux for Swift, the most popular one is [ReduxKit](https://github.com/ReduxKit/ReduxKit) that also offers reactive wrappers.

![States](/images/posts/states_3.png)

## Reactive Programming

### Aiming unidirectional data flow

In this playground with states moving around, paradigms like Reactive Programming contribute creating harmony. The core idea of Reactive Programming is that information flows through streams from data sources. Streams events can be combined, and manipulated but side effects can never be introduced in the equation. How does it relate to states propagation?
Sources of truth, where states are located are the source of these streams. Every time the state changes, the source sends the change through the stream. Interested entities can subscribe to these streams, deciding what to do when the state changes.

### How do we move from the imperative world to a reactive one?

Some frameworks provide components that are based on notifications when state changes take place:

- **`CoreData`:** _NSFetchedResultsController_ notifies when there are changes in the database. We react to these changes, updating our collection, and inserting, updating, deleting items from a collection/table view.
- **`NSUserDefaults`:** We can use _NSNotifications_ to detect when something has changed in user default and then propagate the changes back to the subscribers.
- **`Realm`:** It also provides very generic notifications which might not be enough for your use cases _(they are working on improving them)_. Hopefully, there are libraries like [RealmResultsController](https://github.com/redbooth/RealmResultsController) that implements the idea of _NSFetchedResultsController_ for Realm.

These components could be easily wrapped into _Observables_, or _Signals/SignalProducers_ if you want to work with Reactive concepts. Once wrapped, you can map, filter, combine, observe on a given _scheduler_, … The magic of Reactive.

> Reactive is not a requirement for unidirectional data flow design but makes it easier

## Data source and states

### Performance implications

There are some scenarios where it’s impossible to have a single source of truth because of performance reasons. Accessing data sources like databases or _APIs_ is expensive in term of resources consumption. We cannot execute a request to an _API_ for every row in a _TableView_, or a execute a query against a database every time we render a cell. Those are typical examples where we are forced to duplicate our source of truth and have a cached version that can be quickly accessed _(typically in memory)_.

Whenever you think about cache the source of truth ask yourself the following question:

> Is it expensive in terms of performance?

Is it expensive accessing `NSUserDefaults`? And `Keychain`? If it isn’t why do we create cached copies and add complexity making sure states are synchronized? Can’t the _ApiClient_ have an accessor to `Keychain` instead of the copied token that is restored when the app is opened?

### Examples of cached states

We are forced to cache states in our apps to offer a good experience to our users. Two common scenarios where we cache states are when we’re persisting data from an API in our database since we want the state to be quickly accessed and when we cache a database query results in memory to be presented in a collection view.

**Local database caching an API state**

The reason for persisting the API state in our local database or storage is to make navigation in the app faster. If we download the user repositories on GitHub and persist them in our database, when the user goes into the repositories view we don’t have to show a hilarious spinner while we are downloading the data. The schema of states would be the following one:

![States](/images/posts/states_4.png)

Deciding when the state is synchronized is crucial for a good user experience. Synchronizing it too often can be bad in terms of performance but synchronizing it not enough times can lead to a bad experience. Once you decide which states are going to be persisted from the API and you have a schema of your app structure, design when the states will be synchronized.

> Designing the data model is as important as deciding when the data model is synchronized with the source of truth which is in the API. Be predictive and make sure the states reflect the real value when the user access them.

**Memory collection caching a local database collection**

As I mentioned earlier, due to performance reasons, when the data from a database is accessed we create a cached version in memory that we access to. It means we add a new state to the game, having then the API state, the database state, and our copy in memory of the database state. _Three states that has to be synchronized!_ The schema looks like this one:

![States](/images/posts/states_5.png)

The complexity increases since we need to synchronize two states, the API with the database, and the database with the memory. Plus, the view has to react to the memory copy changes. Since the state is automatically propagated from the presentation layer we have to subscribe to these states and update the view accordingly and trigger the synchronization action.

## Recommendations

We cannot avoid states in our apps, but simplify and avoid derived states. There isn’t a perfect solution, synchronization is complex. You cannot ensure that states are perfectly synchronized since synchronization between local and remote states involves network requests _(and they can fail)_, but at least, follow safe principles that will get us close to the ideal synchronization state. These are some principles that I personally try to follow in my apps:

- **Design where the sources of truth will be:** Where your session will be persisted, where the collections of data will be. And whenever it’s possible, avoid duplicating states. Don’t copy the `Keychain` user session to an instance in memory, or the user profile persisted in `NSUserDefaults` to a copy in memory. If there are no performance implications, don’t copy the data.
- **Designing when the states are synchronizing is as important as designing the states:** You can have a good states design but they are not properly synchronized. Consequently, the user experience of your app is bad. States synchronization is usually driven by your Application lifecycle and navigation. _Be predictive!_
- **Design unidirectional flows for states propagation:** Don’t move states in multiple directions. Derived states should be generated automatically when the source states change.
- **State generation independent from state subscription:** Keep the schema of Flux in mind. With actions states change but nothing else. Any side action is the result of a subscription to these states.

#### I hope you liked the article, the best solution for your app depends on your app itself, its data model, its persistence solution, … Find what’s the architecture that best adapt to your problem and try to keep the principles mentioned above in mind and simplify states!
