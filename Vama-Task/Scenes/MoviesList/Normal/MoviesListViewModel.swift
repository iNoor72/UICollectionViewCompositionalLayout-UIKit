//
//  MainViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import Foundation

struct MoviesListViewModelDependencies: MoviesListViewModelDependenciesProtocol {
    var mainRepository: MoviesListRepositoryProtocol
    var router: MoviesListRouterProtocol
}

protocol MoviesListViewModelDependenciesProtocol {
    var mainRepository: MoviesListRepositoryProtocol { get }
    var router: MoviesListRouterProtocol { get }
}

protocol MoviesListViewModelProtocol {
    var successCompletion: (() -> ())? { get set }
    var failureCompletion: (() -> ())? { get set }
    var page: Int { get set }
    
    func fetchPopularMovies(page: Int) async
    func searchMovies(keyword: String) async
    func refreshData() async
    func getMoviesCount() -> Int
    func getMovie(at index: Int) -> MovieViewItem
    func showError(message: String)
    func routeToMovie(at index: Int)
}

final class MoviesListViewModel: MoviesListViewModelProtocol {
    private let dependencies: MoviesListViewModelDependenciesProtocol
    private var movies: [Movie] = []
    var page = 1
    
    var successCompletion: (() -> ())?
    var failureCompletion: (() -> ())?
    
    init(dependencies: MoviesListViewModelDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    func fetchPopularMovies(page: Int) async {
        guard let result = await dependencies.mainRepository.fetchPopularMovies(page: page) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let response):
            self.movies.append(contentsOf: response.results ?? [])
            successCompletion?()
        }
    }
    
    func searchMovies(keyword: String) async {
        guard let result = await dependencies.mainRepository.searchMovies(keyword: keyword) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let response):
            self.movies = response.results ?? []
            successCompletion?()
        }
    }
    
    func refreshData() async {
        self.movies = []
        await fetchPopularMovies(page: 1)
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
    
    func getMovie(at index: Int) -> MovieViewItem {
        let movie = movies[index]
        return MovieViewItem(
            id: movie.id ?? 0,
            uuid: movie.uuid,
            title: movie.title ?? AppStrings.noTitleStrign,
            posterPath: movie.posterPath ?? "",
            releaseDate: movie.releaseDate ?? "",
            rating: movie.rating ?? 0,
            overview: movie.overview ?? AppStrings.noOverviewStrign
        )
    }
    
    func showError(message: String) {
        dependencies.router.showError(message: message)
    }
    
    func routeToMovie(at index: Int) {
        dependencies.router.navigateToMovieDetails(movieID: movies[index].id ?? 0)
    }
}

struct MovieViewItem: Hashable {
    let id: Int
    let uuid: UUID
    let title: String
    let posterPath: String
    let releaseDate: String
    let rating: Double
    let overview: String
    
    static func ==(lhs: MovieViewItem, rhs: MovieViewItem) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
