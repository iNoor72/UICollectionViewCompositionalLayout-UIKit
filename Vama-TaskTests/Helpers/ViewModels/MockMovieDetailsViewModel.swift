//
//  MockMovieDetailsViewModel.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task

class MockMovieDetailsViewModel: MovieDetailsViewModelProtocol {
    var movie: Vama_Task.MovieViewItem? = MovieViewItem(id: 1, uuid: UUID(), title: "Movie 1", posterPath: "Overview 1", releaseDate: "Poster Path 1", rating: 1, overview: "Release Date 1")
    var successCompletion: (() -> ())?
    var failureCompletion: (() -> ())?
    
    var isFetchDetailsCalled: Bool = false
    
    func fetchMovieDetails() async {
        isFetchDetailsCalled = true
    }
}
