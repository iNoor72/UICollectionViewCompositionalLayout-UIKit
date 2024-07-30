//
//  MainViewFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

protocol MainViewFactoryProtocol: ViewFactoryProtocol {
    func createView() -> UIViewController
}

protocol MainViewFactoryDependenciesProtocol {
    var mainRepository: MainRepositoryProtocol { get }
}

final class MainViewFactory: MainViewFactoryProtocol {
    var dependencies: MainViewFactoryDependenciesProtocol
    
    init(dependencies: MainViewFactoryDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func createView() -> UIViewController {
        let viewModel = MainViewModel(mainRepository: dependencies.mainRepository)
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}

struct MainViewFactoryDependencies: MainViewFactoryDependenciesProtocol {
    var mainRepository: MainRepositoryProtocol
}
