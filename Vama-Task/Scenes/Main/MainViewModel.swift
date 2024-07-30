//
//  MainViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import Foundation

final class MainViewModel {
    private let mainRepository: MainRepositoryProtocol
    private var movies: [Movie] = []
    
    var successCompletion: (() -> ())?
    var failureCompletion: (() -> ())?
    
    init(mainRepository: MainRepositoryProtocol) {
        self.mainRepository = mainRepository
    }
    
    func fetchPopularMovies(page: Int) async {
        guard let result = await mainRepository.fetchPopularMovies(page: page) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let movies):
            self.movies = movies
            successCompletion?()
        }
    }
    
    func searchMovies(keyword: String) async {
        guard let result = await mainRepository.searchMovies(keyword: keyword) else {
            failureCompletion?()
            return
        }
        
        switch result {
        case .failure(_):
            failureCompletion?()
        case .success(let movies):
            self.movies = movies
            successCompletion?()
        }
    }
    
    func refreshData() async {
        await fetchPopularMovies(page: 1)
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
    
    func getMovie(at index: Int) -> MovieViewItem {
        let movie = movies[index]
        return MovieViewItem(
            title: movie.title ?? "No Title",
            posterPath: movie.posterPath ?? "",
            releaseDate: movie.releaseDate ?? "",
            rating: movie.rating ?? 0,
            overview: movie.overview ?? "No overview"
        )
    }
}

struct MovieViewItem {
    let title: String
    let posterPath: String
    let releaseDate: String
    let rating: Double
    let overview: String
}
