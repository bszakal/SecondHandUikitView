# SecondHand
> SecondHand is a market place app which allow users to browse and post announces for objects they would like to buy or sell second hand.
> Live demo [https://youtu.be/9y-Gfg2z9JA]

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Screenshots](#screenshots)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Contact](#contact)
<!-- * [License](#license) -->


## General Information
- The app let users browse announces posted by other users, add them to their favourite, contact users via a real time chat and post their own announces.
- SecondHand is developed using SWIFT UI & UIkit for the Views, UIkit for navigation, and firebase for the backend. 15+ screens
- Followed clean architecture principles, with separation of concerns, dependency injections via Protocols and MVVM + Repo + Coordinator pattern
- Extensive use of asynchronus functions with async/await, combine and callbacks.
- This is the 3rd part of my project of building a market place App for iOS with Swift, the 1st one SecondHand with done 100% with SwiftUI, the 2nd one SecondHandUIkit was using UIkit for the App cycle and the navigation between views but the views themselves were in SwiftUI and for this project I have replaced the Views in the Announce and Favourite sub-flows with UIkit views to showcase my skills and understanding of UIKit and show how you can easily mix UIkit and SwiftUI to benefit the most from both frameworks once you have implemented the right architecture (MVVM + Repo + Coordinator).
- To be noted that for the views I have replaced with UIkit not a single line of code was changed in their view models showing how easily you can mix different UI frameworks with this design pattern using combine for reactive programming.
- In my UIkit views I have used UITableViews & UICollectionViews with custom cells, vertical and horizontal scroll views, searchBar and reusable viewControllers as subview of another Viewcontroller, tapGesture, swipeGesture etc.. These elements are all bound to the VM using combine.
- I use one xib file per view (2 if customm cell is needed) to avoid merge conflict, to limit boiler plate code with big view controllers with too many constraints and programmatic layout where necessary resulting in small View Controllers.
- The views in the Screenshot section are UIkit


## Technologies Used
- Backend: Firebase Firestore and Firebase Storage for images
- Swift UI, UIkit
- async/await, Combine
- 3rd party frameworks: Swinject for dependency injection, NukeUI & SDweb for async loading/display of images, GoogleSignIn, FacebookSignIn

## Features
- Infinite scroll view with pagination and async loading of images
- Log in with Google or email
- Create you own announce
- Manage your favourites
- Real time chat with many different users regarding their announces or the one you created. Automatic scroll to most recent message and show unread messages count
- Create/update your user profile
- import photo from library or camera
- Filtering of announces
- various animations used throughout the project


## Screenshots
<img src="https://user-images.githubusercontent.com/114009067/206210960-71675dcc-5068-4211-8d11-db80b968b329.png" width="325"/> <img src="https://user-images.githubusercontent.com/114009067/206213312-b13e164e-9269-44aa-b518-58970d9a6ec4.png" width="325"/>
<img src="https://user-images.githubusercontent.com/114009067/211019568-34ef54ad-a51f-475a-963f-000f67557ab6.png" width="325"/>
<img src="https://user-images.githubusercontent.com/114009067/211019778-553eb52e-2b4a-4dd4-9faa-aaa7583acb19.png" width="325"/>






## Setup
- Just open the .xcodeproj file, not further installation should be required.



## Usage
Hopefully everything should be fairly intuitive and work as you expect a market place app to work.
- Click on category image in homepageView to get announces filtered by category, or click on searchbar to have more filters available
- Click on heart top right of images to add/remove from favourite.
- Swipe an image to display another one if available for this announce
- Click on announce for detailed view
- Click on Message button at the bottom to start a chat with the user who posted the announce.

- Refer to the video for more, link at the top of the page


## Project Status
I will not keep working on this project as I believe it is big enough to showcase my skills of SwiftUI, UIkit, design pattern and reactive programming. 



## Contact
Created by Benjamin SZAKAL, benjamin.szakal1@gmail.com - feel free to contact me!
