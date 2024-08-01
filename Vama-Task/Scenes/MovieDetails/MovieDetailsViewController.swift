//
//  MovieDetailsViewController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieReleaseDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieContentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var viewModel: MovieDetailsViewModelProtocol!
    init(viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        layoutViews()
        
        viewModel.successCompletion = {[weak self] in
            DispatchQueue.main.async {
                self?.movieImageView.setImage(with: URL(string: APIConstants.imagesBaseURL + (self?.viewModel.movie?.posterPath ?? "")))
                self?.movieTitleLabel.text = self?.viewModel.movie?.title
                self?.movieReleaseDataLabel.text = self?.viewModel.movie?.releaseDate
                self?.movieContentTextView.text = self?.viewModel.movie?.overview
            }
        }
        
        viewModel.failureCompletion = {[weak self] in
            DispatchQueue.main.async {
                let alert = AlertFactory.createAlert(title: AppStrings.errorString, message: "Failed to fetch data")
                self?.present(alert, animated: true)
            }
        }
        
        Task {
            await viewModel.fetchMovieDetails()
        }
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(movieReleaseDataLabel)
        stackView.addArrangedSubview(movieContentTextView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            movieImageView.heightAnchor.constraint(equalToConstant: 350),
            movieImageView.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}
