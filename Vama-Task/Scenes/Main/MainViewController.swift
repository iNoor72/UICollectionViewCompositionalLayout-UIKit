//
//  ViewController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Private properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: self.view.bounds)
        return searchBar
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment
            ) -> NSCollectionLayoutSection? in
            
            let fraction: CGFloat = 1 / 2
            let inset: CGFloat = 6
            let groupInset: CGFloat = 8
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset,
                                                         bottom: inset, trailing: inset)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalWidth(fraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: groupInset,
                                                            bottom: inset, trailing: groupInset)
            
            return section
        }
        
        return layout
    }
    
    
    private let viewModel: MainViewModel!
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
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
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate( [
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movieViewItem = viewModel.getMovie(at: indexPath.row)
        
        cell.configure(name: movieViewItem.title, movieImageURL: movieViewItem.posterPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getMoviesCount() - 1 {
            self.viewModel.page += 1
            Task {
                await self.viewModel.fetchPopularMovies(page: self.viewModel.page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 16
        return CGSize(width: width, height: 230)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else { return }
        Task {
            await viewModel.searchMovies(keyword: searchText)
        }
    }
}
