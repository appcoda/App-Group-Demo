# Using App Groups for communication between macOS/iOS apps from the Same Vendor

Apple’s “app group” technology allows a collection of macOS (or iOS) apps from the same development team, developer, vendor, etc., to all communicate with each other, coordinate functionality, share resources, and minimize redundancies. Apple says this capability “allows the apps within the group to share Mach and POSIX semaphores and to use certain other IPC [interprocess communication] mechanisms among the group’s members.”

In this demo project, I’ll walk you through the configuration and encoding of an app group whose members communicate through a shared instance of UserDefaults, more commonly known as user preferences. One app allows me (and my users) to pick a view background color — like a theme color — and write it to my shared UserDefaults. The other app can read that same shared preference and update its view’s background color to the currently saved value. This process is dynamic. As I change the theme color in one app, the other app can update its view’s background color immediately.

For the full tutorial, please refer to this link:

https://www.appcoda.com/app-group-macos-ios-communication
