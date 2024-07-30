//
//  MainViewModel.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 29/07/2024.
//

import Foundation

final class MainViewModel {
    var mainRepository: MainRepositoryProtocol
    
    init(mainRepository: MainRepositoryProtocol) {
        self.mainRepository = mainRepository
    }
    
    func fetchPopularMovies(page: Int) async {
        await mainRepository.fetchPopularMovies(page: page)
    }
    
    func refreshData() {
        
    }
}
