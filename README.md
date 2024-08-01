# 🍏 Vama-Task
Vama-Task is my implementation for an iOS app to show movies from TMDB website.

## Description
Vama-Task is an iOS app to fetch and present popular movies and their details from TMDB website.

## Getting started
To run the project, you simply open the project and wait for packages to be downloaded
#### The app requires an API key from TMDB website to run it, I'm using mine, but please use your own API key in the APIConstants file to the "APIKey" variable shown in the following screenshot:
<img width="850" alt="Screenshot 2024-08-01 at 2 41 00 PM" src="https://github.com/user-attachments/assets/d5bdcf1d-75c8-4687-8115-c5ddf8c75a7c">

## Video overview
![Simulator Screen Recording - iPhone 15 Pro - 2024-08-01 at 14 50 39](https://github.com/user-attachments/assets/a26178eb-3d06-4a39-922c-f9ca86c6cb58)

## Tech stack
- Swift and Programmatic views using UIKit for the design.
- UICollectionView with UICollectionViewCompositionalLayout.
- SPM for handling packages.
- Used MVVM UI Design Pattern applying Clean Architecture principles (Repository, Layers, Factories) for scalability and testablity. For more info, <a href="https://www.google.com](https://inoor.hashnode.dev/clean-mvp-with-swift">click here</a> to view my article about applying Clean Architecrture principles to any UI Design Pattern.

## Main Features
- List the popular movies for the user to browse them.
- Programmatic UIKit views using UICollectionView with 2 implementations: **UICollectionViewCompositionalLayout** and normal **UICollectionViewFlowLayout**.
- UISearchBar to add search functionality to the app.
- Detailed cell to show the image, headline, rating, and publishing date of a movie.
- Details view for the user to show the details of the desired movie.
- MVVM architecture with Clean Architecture principles and Single Responsibility everywhere!
- Error handling for network and fetching errors.

### Bonus features:
- Pagination for loading movies.
- Used DTO for providing data from Repository to ViewModel to View.
- Mocking for the network and database layers.
- Unit testing for the all layers (Network, Factories, Repositories, and ViewModels) using Mocks.

## Packages
- Alamofire: Used for all of the heavy work of networking in the app.
- Kingfisher: Used for fetching images through URL. Kingfisher is also used for image caching but I disabled this feature.
