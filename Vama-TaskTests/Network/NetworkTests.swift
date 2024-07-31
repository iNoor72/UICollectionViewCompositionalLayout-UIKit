//
//  NetworkTests.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import XCTest
@testable import Vama_Task

final class NetworkTests: XCTestCase {
    var sut: NetworkServiceProtocol!
    
    override func setUp() {
        super.setUp()
        sut = MockNetworkService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_endpoint_construction() {
        let endpoint = MockEndpoint.test
        guard let request = try? endpoint.asURLRequest() else {
            XCTFail()
            return
        }
        XCTAssertEqual(request.url?.absoluteString, "https://test.com/test")
        XCTAssertEqual(request.url?.path(), "/test")
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertNotNil(request.allHTTPHeaderFields?.isEmpty)
        XCTAssertNil(request.httpBody)
    }
    
    func test_successful_fetch() async throws {
        do {
            let result = try await sut.fetch(endpoint: MockEndpoint.test, expectedType: MockModel.self)
            XCTAssertNotNil(result)
            let isFetchCalled = (sut as? MockNetworkService)?.isFetchCalled ?? false
            XCTAssertTrue(isFetchCalled)
        } catch {
            XCTAssertThrowsError(error)
        }
    }
    
    func test_failed_fetch() async throws {
        do {
            (sut as? MockNetworkService)?.makeFetchFail = true
            let result = try await sut.fetch(endpoint: MockEndpoint.test, expectedType: MockModel.self)
            let isFetchCalled = (sut as? MockNetworkService)?.isFetchCalled ?? false
            XCTAssertTrue(isFetchCalled)
            XCTAssertNotNil(result)
            
            switch result {
            case .success(_):
                XCTFail()
                
            case .failure(let error):
                XCTAssertTrue(NetworkErrors.failedToFetchData == error as? NetworkErrors)
            }
        } catch {
            XCTAssertThrowsError(NetworkErrors.failedToFetchData)
        }
    }    
}
