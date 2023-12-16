1)Used SwiftUI as need to write lesser code for UI. It provides a live preview canvas that allows developers to see the changes while they modify the code.

2)The app is compatible with iOS 17+ as i have used Textfield's api onChange(of:initial:_:) because older one is deprecated.

3)Used MVVM architecture design pattern that helps to Separate out business logic from UI

4)Used Singleton design pattern to design a class which includes api logic this helps to have single instance throghout app

5)Used Coordinator pattern (e.g GalleryManager) that coordinates between GalleryViewModel & HTTPClient so if any changes happens then we need to do on GalleryManager only.

6)Used Apple's inbuilt api (AsyncImage) for image as it does caching and it has native SwiftUI support.

7)Used Combine framework that provides a declarative Swift API for processing values over time. It is designed to work seamlessly with SwiftUI.

7)After running the app and typing some value in Xcode you may see some error log in Console, this is due to a bug from Apple end here is the link
https://developer.apple.com/forums/thread/738726 
