//
//  AlamofireNetworkManager.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation
import Alamofire

final class AlamofireNetworkManager: NetworkServiceProtocol {
    func fetch<U: Endpoint, T: Decodable>(endpoint: U, expectedType: T.Type) async throws -> Result<T, Error> {
        guard let reachability = NetworkReachabilityManager(), reachability.isReachable else {
            throw NetworkErrors.noInternet
        }
        
        guard let requestURL = try? endpoint.asURLRequest() else {
            throw NetworkErrors.urlRequestConstructionError
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(requestURL).validate().responseDecodable(queue: .global()) { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                    
                case .success(let data):
                    continuation.resume(returning: .success(data))
                }
            }
        }
    }
}
