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

final class MoviesListViewFactory: MoviesListViewFactoryProtocol {
    func createView() -> UIViewController {
        let repository = MoviesListRepository(network: AlamofireNetworkManager())
        let router = MoviesListRouter()
        let viewModelDependencies = MoviesListViewModelDependencies(mainRepository: repository, router: router)
        
        let viewModel = MoviesListViewModel(dependencies: viewModelDependencies)
        let viewController = MoviesListViewController(viewModel: viewModel)
        router.viewController = viewController
        
        return viewController
    }
}
