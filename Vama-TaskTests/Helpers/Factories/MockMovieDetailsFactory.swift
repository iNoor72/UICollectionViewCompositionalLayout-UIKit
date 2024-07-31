//
//  MockMovieDetailsFactory.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task
import UIKit

final class MockMovieDetailsFactory: MovieDetailsFactoryProtocol {
    func createView() -> UIViewController {
        MockMovieDetailsViewController()
    }
}
