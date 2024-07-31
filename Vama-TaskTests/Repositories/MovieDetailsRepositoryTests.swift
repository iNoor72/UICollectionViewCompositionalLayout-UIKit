//
//  MovieDetailsRepositoryTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MovieDetailsRepositoryTests: XCTestCase {
    var sut: MovieDetailsRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockMovieDetailsRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_movie_details() async {
        guard let result = await sut.fetchMovieDetails(movieID: 1) else {
            XCTFail()
            return
        }
        
        switch result {
        case .success(let movieDetails):
            XCTAssertNotNil(movieDetails)
            
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetch_movie_details_failure() async {
        (sut as? MockMovieDetailsRepository)?.shouldFail = true
        
        guard let result = await sut.fetchMovieDetails(movieID: 1) else {
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
