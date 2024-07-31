//
//  MockMoviesListRepository.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task

final class MockMoviesListRepository: MoviesListRepositoryProtocol {
    let movies = [
        Movie(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "Poster Path 1", releaseDate: "Release Date 1"),
        Movie(id: 2, title: "Movie 2", overview: "Overview 2", posterPath: "Poster Path 2", releaseDate: "Release Date 2"),
        Movie(id: 3, title: "Movie 3", overview: "Overview 3", posterPath: "Poster Path 3", releaseDate: "Release Date 3")
    ]
    
    var shouldFail = false
    func fetchPopularMovies(page: Int) async -> Result<Vama_Task.MovieResponse, Error>? {
        guard !shouldFail else {
            return .failure(NetworkErrors.failedToFetchData)
        }
        return .success(MovieResponse(results: movies))
    }
    
    func searchMovies(keyword: String) async -> Result<Vama_Task.MovieResponse, Error>? {
        guard !shouldFail else {
            return .failure(NetworkErrors.failedToFetchData)
        }
        
        return .success(MovieResponse(results: movies))
    }
}
