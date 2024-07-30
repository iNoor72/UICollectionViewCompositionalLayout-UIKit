//
//  MovieCollectionViewCell.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right") //Disclosure Indicator like in UITableViewCell
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        layoutViews()
    }
    
    
    private func setup() {
        self.addSubview(movieImage)
        self.addSubview(movieNameLabel)
        self.addSubview(accessoryImageView)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = 8.0
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            movieImage.heightAnchor.constraint(equalToConstant: 180),
            
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 8),
            movieNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            movieNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            accessoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            accessoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 20),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(name: String, movieImageURL: String) {
        guard let imageURL = URL(string: (APIConstants.imagesBaseURL + movieImageURL)) else { return }
        
        self.movieImage.setImage(with: imageURL)
        self.movieNameLabel.text = name
    }
}
