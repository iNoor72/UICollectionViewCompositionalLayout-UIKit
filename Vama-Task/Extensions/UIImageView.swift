//
//  UIImageView.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        kf.setImage(with: url) {[weak self] result in
            guard let self else { return }
            switch result {
            case .failure(_):
                self.image = UIImage(systemName: "photo")
            case .success(let result):
                self.image = result.image
            }
        }
    }
}
