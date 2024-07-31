//
//  MovieDetailsViewModelTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MovieDetailsViewModelTests: XCTestCase {
    var sut: MovieDetailsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockMovieDetailsViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchMovieDetails() async {
        await sut.fetchMovieDetails()
        let isFetchMovieDetailsCalled = (sut as? MockMovieDetailsViewModel)?.isFetchDetailsCalled ?? false
        XCTAssertTrue(isFetchMovieDetailsCalled)
    }
}
