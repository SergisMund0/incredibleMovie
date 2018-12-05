//
//  PopularMovies.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

struct DashboardInjectionModel {
    let minimumDate: String
    let maximumDate: String
    let viewDataModel: [MovieCellViewModel]
}

struct MovieCellViewModel {
    let title: String
    let backgroundImageURL: String
    let subtitle: String?
    let rating: String
    let releaseDate: String
    var imageData: UIImage?
}

struct PopularMovies: Codable {
    let page, totalResults, totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Result: Codable {
    let originalName: String
    let genreIDS: [Int]
    let name: String
    let popularity: Double
    let originCountry: [String]
    let voteCount: Int
    let firstAirDate: String
    let backdropPath: String?
    let originalLanguage: String
    let id: Int
    let voteAverage: Double
    let overview: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
