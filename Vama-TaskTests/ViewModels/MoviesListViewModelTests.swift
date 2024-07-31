//
//  MoviesListViewModelTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MoviesListViewModelTests: XCTestCase {
    var sut: MoviesListViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockMoviesListViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_Movies() async {
        await sut.fetchPopularMovies(page: 1)
        XCTAssert(sut.getMoviesCount() > 0)
        
        let fetchMoviesCalledCount = (sut as? MockMoviesListViewModel)?.fetchMoviesCalledCount ?? 0
        let isFetchMoviesCalled = (sut as? MockMoviesListViewModel)?.fetchMoviesCalled ?? false
        
        XCTAssertTrue(isFetchMoviesCalled)
        XCTAssertEqual(fetchMoviesCalledCount, 1)
    }
    
    func test_search_Movies() async {
        await sut.searchMovies(keyword: "test")
        XCTAssert(sut.getMoviesCount() > 0)
        
        let searchMoviesCalledCount = (sut as? MockMoviesListViewModel)?.searchMoviesCalledCount ?? 0
        let isSearchMoviesCalled = (sut as? MockMoviesListViewModel)?.searchMoviesCalled ?? false
        
        XCTAssertTrue(isSearchMoviesCalled)
        XCTAssertEqual(searchMoviesCalledCount, 1)
    }
    
    func test_refresh_data() async {
        await sut.refreshData()
        XCTAssert(sut.getMoviesCount() > 0)
        
        let fetchMoviesCalledCount = (sut as? MockMoviesListViewModel)?.fetchMoviesCalledCount ?? 0
        let isFetchMoviesCalled = (sut as? MockMoviesListViewModel)?.fetchMoviesCalled ?? false
        
        XCTAssertTrue(isFetchMoviesCalled)
        XCTAssertEqual(fetchMoviesCalledCount, 1)
    }
    
    func test_search_then_refresh() async {
        await sut.searchMovies(keyword: "test")
        XCTAssert(sut.getMoviesCount() > 0)
        
        let searchMoviesCalledCount = (sut as? MockMoviesListViewModel)?.searchMoviesCalledCount ?? 0
        let isSearchMoviesCalled = (sut as? MockMoviesListViewModel)?.searchMoviesCalled ?? false
        
        XCTAssertTrue(isSearchMoviesCalled)
        XCTAssertEqual(searchMoviesCalledCount, 1)
        
        
        await sut.refreshData()
        XCTAssert(sut.getMoviesCount() > 0)
        
        let fetchMoviesCalledCount = (sut as? MockMoviesListViewModel)?.fetchMoviesCalledCount ?? 0
        let isFetchMoviesCalled = (sut as? MockMoviesListViewModel)?.fetchMoviesCalled ?? false
        
        XCTAssertTrue(isFetchMoviesCalled)
        XCTAssertEqual(fetchMoviesCalledCount, 1)
    }
}
