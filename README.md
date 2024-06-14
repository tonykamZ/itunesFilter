# itunesFilter 🎵
An iOS app written in SwiftUI that allows users to search, filter and sort songs using the iTunes API.
## Table of Contents

- [Installation](#installation)
- [Features](#features)
- [User Requirements](#user-requirements)

## Installation

To install and run TuneFilter on your iOS device, follow these steps:

1. Clone the repository:
$ git clone https://github.com/tonykamZ/itunesFilter.git

2. Open the folder with latest Xcode, which is available on the App Store.

3. Wait for Xcode to initialize the project and index the files

4. In Xcode, go to "Targets" > "TuneFinder" > "Signing & Capabilities".

5. Log in to your Apple ID and check the "Automatically manage signing" option to create the signing certificate

6. Click the run button in Xcode to build the project, targeting your desired device (either simulator or physical device)
   **Reminder: Adjust the minimum iOS version of deployment as needed (support iOS 14+)

7. Wait for a while, and the app will be built onto your simulator or physical device!🎉🎉

## Features

TuneFilter offers the following features ✨✨

Caching: The app will store the cached data of the api response for easy and quick access.

Filtering: Users can perform real-time filtering of search results by typing keywords on the input field.

Sorting: Users can sort songs by song name or album name.

<img src="https://github.com/tonykamZ/tuneFilter/assets/67361009/ccdd03df-2847-458e-9c9e-0d2ba3c1a301" width="160" height="300">
<img src="https://github.com/tonykamZ/tuneFilter/assets/67361009/01df9cef-0e5a-4f64-881a-26303c94d986" width="160" height="300">
<img src="https://github.com/tonykamZ/tuneFilter/assets/67361009/2dfe1d0a-f12c-4973-b78e-16db0a21c941" width="160" height="300">

Feel free to explore TuneFilter and enjoy discovering new music right at your fingertips!

## User Requirements

requested user requirements could be located in the code base. The format is "// Requirement 1A: ...", where 1A can be replaced by the desired item

1A. The app should fetch the song list as cached data when app started with following criteria:
    Using API endpoint https://itunes.apple.com/search?term=Talyor+Swift&limit=200&media=music

2A. UI should contain one input field for user to input keyword, and searching should be performed after user adding/removing a letter in the input field

2B. Search by Song Name and Album Name

3A. The app should allow users to sort the cached list where UI should contain two radio buttons, that default one is for sorting by Song Name, and another is for sorting by Album Name.

3B. Sorting the list by ascending order.

4A. The app should display the search results in a list showing the Song Name, Album Name, and Album Art where UI should contain a list showing result filtered and sorted by specific criteria.

4B. The app should handle network error state and result empty state.





