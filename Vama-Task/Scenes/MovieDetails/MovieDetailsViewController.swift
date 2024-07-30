//
//  MovieDetailsViewController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let viewModel: MovieDetailsViewModel!
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
