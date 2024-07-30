//
//  MovieDetailsRepository.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

protocol MovieDetailsRepositoryProtocol {
    func fetchMovieDetails(movieID: Int) async -> Result<Movie, Error>?
}

protocol MovieDetailsRepositoryDependenciesProtocol {
    var network: NetworkServiceProtocol { get }
}

final class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func fetchMovieDetails(movieID: Int) async -> Result<Movie, Error>? {
        let endpoint = MoviesEndpoint.movieDetails(movieID: movieID)
        return try? await network.fetch(endpoint: endpoint, expectedType: Movie.self)
    }
}
