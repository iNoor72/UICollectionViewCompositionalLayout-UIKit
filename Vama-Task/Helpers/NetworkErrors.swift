//
//  NetworkErrors.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

enum NetworkErrors: Error {
    case urlRequestConstructionError
    case noInternet
    case failedToFetchData
}
