//
//  MockEndpoint.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
import Alamofire
@testable import Vama_Task

enum MockEndpoint: Endpoint {
    var parameters: Parameters? {
        nil
    }
    
    var method: HTTPMethod {
        .get
    }
    
    case test
    
    var baseURL: URL {
        return URL(string: "https://test.com")!
    }
    
    var path: String {
        return "/test"
    }
}
