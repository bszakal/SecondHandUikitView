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
- SecondHand is developed using SWIFT UI for the Views, UIkit for navigation, and firebase for the backend. 15+ screens
- Followed clean architecture principles, with separation of concerns, dependency injections via Protocols and MVVM + Repo + Coordinator pattern
- Extensive use of asynchronus functions with async/await, combine and callbacks.
- This project is based on the orginial project SecondHand, is aims to show how you harness the power of SwiftUI while keeping the project in UIkit and benefit from the ability to separate Views from the routing flow to adhere to SOLID principles


## Technologies Used
- Backend: Firebase Firestore and Firebase Storage for images
- Swift UI, UIkit
- async/await, Combine
- 3rd party frameworks: Swinject for dependency injection, NukeUI for async loading/display of images, Quick/Nimble for unit tests,  GoogleSignIn, FacebookSignIn

## Features
- Infinite scroll view with pagination, and pull to refresh announces, and async loading of images
- Log in with Google, Facebook or email
- Create you own announce
- Manage your favourites
- Real time chat with many different users regarding their announces or the one you created. Automatic scroll to most recent message and show unread messages count
- Create/update your user profile
- import photo from library or camera
- Filtering of announces
- various animations used throughout the project


## Screenshots
<img src="https://user-images.githubusercontent.com/114009067/206210960-71675dcc-5068-4211-8d11-db80b968b329.png" width="325"/> <img src="https://user-images.githubusercontent.com/114009067/206210700-2f37a4e9-1739-46bb-b98b-92c46d57495e.png" width="325"/> <img src="https://user-images.githubusercontent.com/114009067/206213312-b13e164e-9269-44aa-b518-58970d9a6ec4.png" width="325"/>
<img src="https://user-images.githubusercontent.com/114009067/206213901-87ffd1ce-e21e-4618-91af-f5cfa9d01ddc.png" width="325"/> <img src="https://user-images.githubusercontent.com/114009067/206216250-e2942f7e-94e7-4021-90de-22f65a4ef13c.png" width="325"/> <img src="https://user-images.githubusercontent.com/114009067/206216758-f47cc0a8-6e00-4d64-8b78-075c393907f4.png" width="325"/>



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
The goal of this project was to enable me to show how you can benefit from ease of building views with SWFIT UI while keeping the project in UIkit so that Apps currently running on UIkit can use this example to at least start using Swift UI for new screens/features. So if the project is currently in using MVC it should first be changed to MVVM, routing logic should be extracted from the Views and then you can start using Swift ui for new features or replace XIB/viewControllers, file by file without having to much the all App structure at once. I won't keep working on this project as I feel it's big enough to show that this pattern could be useful to many companies.


## Contact
Created by Benjamin SZAKAL, benjamin.szakal1@gmail.com - feel free to contact me!
