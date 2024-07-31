//
//  MoviesListFactoryTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class MoviesListFactoryTests: XCTestCase {
    func test_createView() {
        let factory = MockMoviesListFactory()
        let viewController = factory.createView()
        XCTAssertNotNil(viewController)
        XCTAssert(viewController is MockMoviesListViewController)
    }
    
    func test_real_createView() {
        let factory = MoviesListViewFactory()
        let viewController = factory.createView()
        XCTAssertNotNil(viewController)
        XCTAssert(viewController is MoviesListViewController)
    }
}
