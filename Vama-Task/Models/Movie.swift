//
//  Movie.swift
//  Vama-Task
//
//  Created by Noor El-Din Walid on 30/07/2024.
//

import Foundation

struct MovieResponse: Codable {
    var results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Movie: Codable, Hashable {
    var id: Int?
    var title: String?
    var overview: String?
    var posterPath: String?
    var rating: Double?
    var releaseDate: String?
    let uuid = UUID()
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "backdrop_path"
        case rating = "vote_average"
        case releaseDate = "release_date"
    }
}
