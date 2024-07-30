//
//  MainRepository.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

protocol MainRepositoryProtocol {
//    func fetchPopularMovies(page: Int) async -> (Result<[Movie], Error>)
}

protocol MainRepositoryDependenciesProtocol {
    var network: NetworkServiceProtocol { get }
}

final class MainRepository: MainRepositoryProtocol {
    private let network: NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol) {
        self.network = network
    }
    
//    func fetchPopularMovies(page: Int) async -> (Result<[Movie], Error>) {
////        let endpoint =
////        return await network.fetch(endpoint: endpoint, expectedType: [Movie].self)
//    }
}
