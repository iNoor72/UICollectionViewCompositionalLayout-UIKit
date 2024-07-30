//
//  MovieDetailsViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

final class MovieDetailsViewModel {
    private let movieDetailsRepository: MovieDetailsRepositoryProtocol
    
    init(movieDetailsRepository: MovieDetailsRepositoryProtocol) {
        self.movieDetailsRepository = movieDetailsRepository
    }
}
