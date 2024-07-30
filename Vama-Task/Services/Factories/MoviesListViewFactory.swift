//
//  MainViewFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

protocol MoviesListViewFactoryProtocol: ViewFactoryProtocol {
    func createView() -> UIViewController
}

protocol MoviesListViewFactoryDependenciesProtocol {
    var mainRepository: MoviesListRepositoryProtocol { get }
}

final class MoviesListViewFactory: MoviesListViewFactoryProtocol {
    var dependencies: MoviesListViewFactoryDependenciesProtocol
    
    init(dependencies: MoviesListViewFactoryDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func createView() -> UIViewController {
        let viewModel = MoviesListViewModel(mainRepository: dependencies.mainRepository)
        let viewController = MoviesListViewController(viewModel: viewModel)
        return viewController
    }
}

struct MoviesListViewFactoryDependencies: MoviesListViewFactoryDependenciesProtocol {
    var mainRepository: MoviesListRepositoryProtocol
}
