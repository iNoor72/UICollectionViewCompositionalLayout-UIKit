//
//  MovieCollectionViewCell.swift
//  VeryCreatives-Task
//
//  Created by Noor Walid on 14/04/2022.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {    
    private let accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right") //Disclosure Indicator like in UITableViewCell
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
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
        self.addSubview(movieRatingLabel)
        self.addSubview(movieReleaseDateLabel)
        self.addSubview(starImage)
        
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = 8.0
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            starImage.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 8),
            starImage.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -8),
            starImage.widthAnchor.constraint(equalToConstant: 20),
            starImage.heightAnchor.constraint(equalToConstant: 20),
            
            movieRatingLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 8),
            movieRatingLabel.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            movieRatingLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            movieReleaseDateLabel.bottomAnchor.constraint(equalTo: starImage.topAnchor, constant: -16),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 8),
            
            
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 8),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            movieNameLabel.bottomAnchor.constraint(equalTo: movieReleaseDateLabel.topAnchor, constant: -8),
            
            accessoryImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            accessoryImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 20),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(name: String, movieImageURL: String, rating: Double, releaseDate: String) {
        guard let imageURL = URL(string: (APIConstants.imagesBaseURL + movieImageURL)) else { return }
        
        self.movieImage.setImage(with: imageURL)
        self.movieNameLabel.text = name
        self.movieRatingLabel.text = String(Int(rating))
        self.movieReleaseDateLabel.text = releaseDate
    }
    
    func configure(item: MovieViewItem) {
        guard let imageURL = URL(string: (APIConstants.imagesBaseURL + item.posterPath)) else { return }
        
        self.movieImage.setImage(with: imageURL)
        self.movieNameLabel.text = item.title
        self.movieRatingLabel.text = String(Int(item.rating))
        self.movieReleaseDateLabel.text = item.releaseDate
    }
}
