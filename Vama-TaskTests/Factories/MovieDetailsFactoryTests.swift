//
//  MovieDetailsFactoryTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MovieDetailsFactoryTests: XCTestCase {
    func test_createView() {
        let factory = MockMovieDetailsFactory()
        let viewController = factory.createView()
        XCTAssertNotNil(viewController)
        XCTAssert(viewController is MockMovieDetailsViewController)
    }
    
    func test_real_createView() {
        let factory = MovieDetailsFactory()
        let viewController = factory.createView()
        XCTAssertNotNil(viewController)
        XCTAssert(viewController is MovieDetailsViewController)
    }
}
