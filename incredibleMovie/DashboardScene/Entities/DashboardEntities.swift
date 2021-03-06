//
//  PopularMovies.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

// This is the input model when the
// view needs to change its state
struct DashboardInjectionModel {
    let filterViewModel: FilterViewModel
    var movieCellModel: [MovieCellModel]
}

// This is the output model when a user takes
// an action over the UI
struct DashboardDelegateModel {
    let minimumSelectedDate: String
    let maximumSelectedDate: String
    let selectedMovieCellModel: MovieCellModel
    
    init(minimumSelectedDate: String = FilterResources.minimumYearNumberString,
         maximumSelectedDate: String = FilterResources.maximumYearNumberString,
         selectedMovieCellModel: MovieCellModel) {
        
        self.minimumSelectedDate = minimumSelectedDate
        self.maximumSelectedDate = maximumSelectedDate
        self.selectedMovieCellModel = selectedMovieCellModel
    }
}

// We use this model to apply the filters
struct DateRange {
    let minimumYearDate: String
    let maximumYearDate: String
    
    init(minimumYearDate: String = FilterResources.minimumYearNumberString,
         maximumYearDate: String = FilterResources.maximumYearNumberString) {
        
        self.minimumYearDate = "\(minimumYearDate)-01-02"
        self.maximumYearDate = "\(maximumYearDate)-12-28"
    }
}

// The data retrieved from the Server for the Popular Movies
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
