//
//  CompositionalMoviesListFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import UIKit

final class CompositionalMoviesListFactory: MoviesListViewFactoryProtocol {
    func createView() -> UIViewController {
        let repository = MoviesListRepository(network: AlamofireNetworkManager())
        let router = MoviesListRouter()
        let viewModelDependencies = MoviesListViewModelDependencies(mainRepository: repository, router: router)
        
        let viewModel = CompositionalMoviesListViewModel(dependencies: viewModelDependencies)
        let viewController = CompositionalMoviesListViewController(viewModel: viewModel)
        router.viewController = viewController
        
        return viewController
    }
}
