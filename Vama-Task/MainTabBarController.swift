//
//  MainTabBarController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        setupViewControllers()
    }

    private func setupViewControllers() {
        let moviesListFactory = MoviesListViewFactory()
        let moviesListViewController = moviesListFactory.createView()
        let moviesListNavigationController = UINavigationController(rootViewController: moviesListViewController)
        moviesListViewController.tabBarItem.title = "Normal Layout"
        moviesListViewController.tabBarItem.image = UIImage(systemName: "list.bullet.circle.fill")
        moviesListViewController.title = "Normal Layout"
        
        let compositionalMoviesListFactory = CompositionalMoviesListFactory()
        let compositionalMoviesListViewController = compositionalMoviesListFactory.createView()
        let compositionalMoviesListNavigationController = UINavigationController(rootViewController: compositionalMoviesListViewController)
        compositionalMoviesListViewController.tabBarItem.title = "Compositional Layout"
        compositionalMoviesListViewController.tabBarItem.image = UIImage(systemName: "rectangle.3.group.fill")
        compositionalMoviesListViewController.title = "Compositional Layout"
        
        self.viewControllers = [moviesListNavigationController, compositionalMoviesListNavigationController]
    }
}
