//
//  AlertFactory.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit

final class AlertFactory {
    static func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AppStrings.okString, style: .default, handler: nil))
        return alert
    }
}
