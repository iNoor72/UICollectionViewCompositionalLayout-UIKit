//
//  CompositionalMoviesListViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation

protocol CompositionalMoviesListViewModelProtocol: MoviesListViewModelProtocol {
    var movies: [PageSection: [MovieViewItem]] { get }
}

final class CompositionalMoviesListViewModel: CompositionalMoviesListViewModelProtocol {
    var movies: [PageSection: [MovieViewItem]] = [.content: []]
    private let dependencies: MoviesListViewModelDependenciesProtocol
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
            guard let movies = response.results else { return }
            
            movies.forEach {
                self.movies[.content]?.append(MovieViewItem(id: $0.id ?? 0, uuid: $0.uuid, title: $0.title ?? "", posterPath: $0.posterPath ?? "", releaseDate: $0.releaseDate ?? "", rating: $0.rating ?? 0, overview: $0.overview ?? ""))
            }
            successCompletion?()
        }
    }
    
    func searchMovies(keyword: String) async {
        self.movies[.content] = []
        guard let result = await dependencies.mainRepository.searchMovies(keyword: keyword) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let response):
            guard let movies = response.results else { return }
            
            movies.forEach {
                self.movies[.content]?.append(MovieViewItem(id: $0.id ?? 0, uuid: $0.uuid, title: $0.title ?? "", posterPath: $0.posterPath ?? "", releaseDate: $0.releaseDate ?? "", rating: $0.rating ?? 0, overview: $0.overview ?? ""))
            }
            successCompletion?()
        }
    }
    
    func refreshData() async {
        self.movies[.content] = []
        await fetchPopularMovies(page: 1)
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
    
    func getMovie(at index: Int) -> MovieViewItem {
        guard let movie = movies[.content]?[safe: index] as? MovieViewItem else { return MovieViewItem(
            id: 0,
            uuid: UUID(),
            title: AppStrings.noTitleStrign,
            posterPath: "",
            releaseDate: "",
            rating: 0,
            overview: AppStrings.noOverviewStrign
        ) }
        return movie
    }
    
    func showError(message: String) {
        dependencies.router.showError(message: message)
    }
    
    func routeToMovie(at index: Int) {
        dependencies.router.navigateToMovieDetails(movieID: movies[.content]?[safe: index]?.id ?? 0)
    }
}
