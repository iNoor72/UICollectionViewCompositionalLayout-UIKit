//
//  MovieDetailsFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit

protocol MovieDetailsFactoryProtocol: ViewFactoryProtocol {
    func createView() -> UIViewController
}

protocol MovieDetailsFactoryDependenciesProtocol {
    var movieDetailsRepository: MovieDetailsRepositoryProtocol { get }
}

final class MovieDetailsFactoryFactory: MovieDetailsFactoryProtocol {
    var dependencies: MovieDetailsFactoryDependenciesProtocol
    
    init(dependencies: MovieDetailsFactoryDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func createView() -> UIViewController {
        let viewModel = MovieDetailsViewModel(movieDetailsRepository: dependencies.movieDetailsRepository)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        return viewController
    }
}

struct MovieDetailsFactoryFactoryDependencies: MovieDetailsFactoryDependenciesProtocol {
    var movieDetailsRepository: MovieDetailsRepositoryProtocol
}
