//
//  MockMoviesListViewModel.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task

final class MockMoviesListViewModel: MoviesListViewModelProtocol {
    var successCompletion: (() -> ())?
    var failureCompletion: (() -> ())?
    var page: Int = 0
    var movies: [Movie] = [Movie(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "Poster Path 1", releaseDate: "Release Date 1")]
    
    var fetchMoviesCalled: Bool = false
    var fetchMoviesCalledCount: Int = 0
    
    var searchMoviesCalled: Bool = false
    var searchMoviesCalledCount: Int = 0
    
    var isRouteToMovieDetailsCalled = false
    var isShowErrorCalled = false

    func fetchPopularMovies(page: Int) async {
        fetchMoviesCalled = true
        fetchMoviesCalledCount += 1
    }
    
    func searchMovies(keyword: String) async {
        searchMoviesCalled = true
        searchMoviesCalledCount += 1
    }
    
    func refreshData() async {
        await fetchPopularMovies(page: 1)
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
    
    func getMovie(at index: Int) -> Vama_Task.MovieViewItem {
        MovieViewItem(id: movies[0].id ?? 0, uuid: UUID(), title: movies[0].title ?? "", posterPath: movies[0].posterPath ?? "", releaseDate: movies[0].releaseDate ?? "", rating: movies[0].rating ?? 0, overview: movies[0].overview ?? "")
    }
    
    func showError(message: String) {
        isShowErrorCalled = true
    }
    
    func routeToMovie(at index: Int) {
        isRouteToMovieDetailsCalled = true
    }
    
}
