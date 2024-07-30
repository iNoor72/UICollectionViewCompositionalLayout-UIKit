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

final class MovieDetailsFactory: MovieDetailsFactoryProtocol {
    func createView() -> UIViewController {
        let repository = MovieDetailsRepository(network: AlamofireNetworkManager())
        let viewModel = MovieDetailsViewModel(movieDetailsRepository: repository)
        viewModel.movieID = UserDefaults.standard.integer(forKey: "movieID")
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        return viewController
    }
}
