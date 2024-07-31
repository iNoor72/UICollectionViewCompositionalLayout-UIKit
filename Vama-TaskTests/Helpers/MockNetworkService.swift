//
//  MockNetworkService.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task

final class MockNetworkService: NetworkServiceProtocol {
    var isFetchCalled = false
    var makeFetchFail = false
    
    func fetch<U: Endpoint, T: Decodable>(endpoint: U, expectedType: T.Type) async throws -> Result<T, Error> {
        isFetchCalled = true
        
        if makeFetchFail {
            return .failure(NetworkErrors.failedToFetchData)
        }
        
        let json = """
                {
                    "id": 1,
                    "name": "Noor",
                    "body": "Test"
                }
                """
        do {
            let data = Data(json.utf8)
            let response = try JSONDecoder().decode(T.self, from: data)
            return .success(response)
        } catch {
            return .failure(NetworkErrors.failedToFetchData)
        }
    }
}
