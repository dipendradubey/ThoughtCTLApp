1)Used SwiftUI as needed to write lesser code for UI. It provides a live preview canvas that allows developers to see the changes while they modify the code.

2)The app is compatible with iOS 17+ as I have used Textfield's API onChange(of:initial:_:) because the older one is deprecated.

3)Used MVVM architecture design pattern that helps to separate business logic from UI

4)Used Singleton design pattern to design a class (e.g. HTTPClient) that includes API logic this helps to have a single instance throughout the app

5)Used Coordinator pattern (e.g. GalleryManager) that coordinates between GalleryViewModel & HTTPClient so if any changes happen then we need to do it on GalleryManager only.

6)Used Apple's inbuilt API (AsyncImage) for images as it does caching and it has native SwiftUI support.

7)Used Combine framework that provides a declarative Swift API for processing values over time. It is designed to work seamlessly with SwiftUI.

7)After running the app and typing some value in TextField you may see some error log in the Console, this is due to a bug from Apple's end. Below is the link
https://developer.apple.com/forums/thread/738726 
