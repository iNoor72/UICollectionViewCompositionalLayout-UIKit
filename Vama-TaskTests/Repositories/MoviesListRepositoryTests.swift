//
//  MoviesListRepositoryTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MoviesListRepositoryTests: XCTestCase {
    var sut: MoviesListRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockMoviesListRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchMovies() async {
        guard let result = await sut.fetchPopularMovies(page: 1) else {
            XCTFail()
            return
        }
        
        switch result {
        case .failure(_):
            XCTFail()
            
        case .success(let response):
            XCTAssertEqual(response.results?.count, 3)
        }
    }
    
    func test_searchMovies() async {
        guard let result = await sut.searchMovies(keyword: "test") else {
            XCTFail()
            return
        }
        
        switch result {
        case .failure(_):
            XCTFail()
            
        case .success(let response):
            XCTAssertEqual(response.results?.count, 3)
        }
    }
    
    func test_fetchMovies_failure() async {
        (sut as? MockMoviesListRepository)?.shouldFail = true
        guard let result = await sut.fetchPopularMovies(page: 1) else {
            XCTFail()
            return
        }
        
        switch result {
        case .success(_):
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error as? NetworkErrors, NetworkErrors.failedToFetchData)
        }
    }
    
    func test_searchMovies_failure() async {
        (sut as? MockMoviesListRepository)?.shouldFail = true
        guard let result = await sut.searchMovies(keyword: "test") else {
            XCTFail()
            return
        }
        
        switch result {
        case .success(_):
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error as? NetworkErrors, NetworkErrors.failedToFetchData)
        }
    }
}
