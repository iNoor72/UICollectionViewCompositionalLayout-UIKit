//
//  ViewController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: - Private properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: self.view.bounds)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    private var viewModel: MoviesListViewModelProtocol!
    
    init(viewModel: MoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        
        viewModel.failureCompletion = {[weak self] in
            DispatchQueue.main.async {
                let alert = AlertFactory.createAlert(title: "Error", message: "Failed to fetch data")
                self?.present(alert, animated: true)
            }
        }
        
        viewModel.successCompletion = {[weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        Task {
            await viewModel.fetchPopularMovies(page: 1)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.itemSize = CGSize(width: collectionView.frame.width - 16, height: collectionView.frame.height / 4)
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TEST", for: indexPath) as? TestCell else { return UICollectionViewCell() }
        let movieViewItem = viewModel.getMovie(at: indexPath.row)
        
        cell.configure(name: movieViewItem.title, movieImageURL: movieViewItem.posterPath, rating: movieViewItem.rating, releaseDate: movieViewItem.releaseDate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.routeToMovie(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMoviesCount() - 1 {
            self.viewModel.page += 1
            Task {
                await self.viewModel.fetchPopularMovies(page: self.viewModel.page)
            }
        }
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            Task {
                await viewModel.refreshData()
            }
            return
        }
        
        guard searchText.count > 2 else { return }
        
        Task {
            await viewModel.searchMovies(keyword: searchText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        Task {
            await viewModel.refreshData()
        }
    }
}
