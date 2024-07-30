//
//  MainRepository.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

protocol MainRepositoryProtocol {
    func fetchPopularMovies(page: Int) async -> Result<MovieResponse, Error>?
    func searchMovies(keyword: String) async -> Result<MovieResponse, Error>?
}

protocol MainRepositoryDependenciesProtocol {
    var network: NetworkServiceProtocol { get }
}

final class MainRepository: MainRepositoryProtocol {
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
    func fetchPopularMovies(page: Int) async -> Result<MovieResponse, Error>? {
        let endpoint = MoviesEndpoint.popularMovies(page: page)
        return try? await network.fetch(endpoint: endpoint, expectedType: MovieResponse.self)
    }
    
    func searchMovies(keyword: String) async -> Result<MovieResponse, Error>? {
        let endpoint = MoviesEndpoint.searchMovies(keyword: keyword)
        return try? await network.fetch(endpoint: endpoint, expectedType: MovieResponse.self)
    }
}
