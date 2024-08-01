//
//  CompositionalMoviesListViewController.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import UIKit

enum PageSection: Hashable, CaseIterable {
    //    case header
    case content
    //    case footer
}

enum PageItem: Hashable {
    //    case header(String)
    case content(MovieViewItem)
    //    case footer(String)
}

class CompositionalMoviesListViewController: UIViewController {
    // MARK: - Private properties
    typealias DataSource = UICollectionViewDiffableDataSource<PageSection, MovieViewItem>
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: self.view.bounds)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = PageSection.allCases[sectionIndex]
            
            switch section {
            case .content:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(self.collectionView.frame.height / 3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
                return NSCollectionLayoutSection(group: group)
            }
        }
        return layout
    }
    
    lazy var dataSource = UICollectionViewDiffableDataSource<PageSection, MovieViewItem>(collectionView: collectionView) { collectionView, indexPath, item in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item: item)
        return cell
    }
    
    private var viewModel: CompositionalMoviesListViewModelProtocol!
    
    init(viewModel: CompositionalMoviesListViewModelProtocol) {
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
                self?.applySnapshot()
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
        collectionView.dataSource = makeDataSource()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier)
        collectionView.prefetchDataSource = self
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
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<PageSection, MovieViewItem>()
        
        for (section, items) in viewModel.movies {
            snapshot.appendSections([section])
            snapshot.appendItems(items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CompositionalMoviesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.routeToMovie(at: indexPath.row)
    }
}

extension CompositionalMoviesListViewController: UISearchBarDelegate {
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
}

extension CompositionalMoviesListViewController {
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, item: MovieViewItem) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CollectionViewCells.movieCollectionViewCellIdentifier, for: indexPath) as? MovieCollectionViewCell else { return nil }
        let item = viewModel.getMovie(at: indexPath.row)
        cell.configure(item: item)
        return cell
    }
    
    public func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        self.dataSource = dataSource
        return dataSource
    }
}

extension CompositionalMoviesListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(item: collectionView.numberOfItems(inSection: 0) - 1, section: 0)
        if indexPaths.contains(lastIndexPath) {
            self.viewModel.page += 1
            Task {
                await self.viewModel.fetchPopularMovies(page: self.viewModel.page)
            }
        }
    }
}
