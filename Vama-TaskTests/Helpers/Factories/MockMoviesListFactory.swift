//
//  MockMoviesListFactory.swift
//  Vama-TaskTests
//
//  Created by Noor El-Din Walid on 31/07/2024.
//

import Foundation
@testable import Vama_Task
import UIKit

final class MockMoviesListFactory: MoviesListViewFactoryProtocol {
    func createView() -> UIViewController {
        MockMoviesListViewController()
    }
}
