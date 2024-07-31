//
//  MockMovieDetailsRepository.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task

final class MockMovieDetailsRepository: MovieDetailsRepositoryProtocol {
    let movieDetails = Movie(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "Poster Path 1", releaseDate: "Release Date 1")
    var shouldFail = false
    
    func fetchMovieDetails(movieID: Int) async -> Result<Vama_Task.Movie, Error>? {
        guard !shouldFail else {
            return .failure(NetworkErrors.failedToFetchData)
        }
        return .success(movieDetails)
    }
}
