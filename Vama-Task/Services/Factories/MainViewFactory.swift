//
//  MainViewFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

protocol MainViewFactoryProtocol: ViewFactoryProtocol {
    var viewModel: MainViewModel { get }
}

final class MainViewFactory: MainViewFactoryProtocol {
    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func createView() -> UIViewController {
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }
}
