//
//  MoviesListRouter.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit

protocol MoviesListRouterProtocol {
    var viewController: UIViewController? { get }
    
    func navigateToMovieDetails(movieID: Int)
    func showError(message: String)
}

final class MoviesListRouter: MoviesListRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToMovieDetails(movieID: Int) {
        UserDefaults.standard.setValue(movieID, forKey: "movieID")
        let movieDetailsFactory = MovieDetailsFactory()
        let movieDetailsViewController = movieDetailsFactory.createView()
        viewController?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showError(message: String) {
        let alert = AlertFactory.createAlert(title: "Error", message: message)
        viewController?.present(alert, animated: true)
    }
}
