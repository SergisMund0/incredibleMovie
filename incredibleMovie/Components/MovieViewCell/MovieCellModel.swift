//
//  MovieCellModel.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 05/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

struct MovieCellModel {
    let backgroundImageURL: String
    let title: String
    let releaseDate: String
    
    // Once the view has been loaded, we hold the data in memory to
    // send to the next view
    var backgroundImageData: UIImage?
    let overviewContent: String?
    let rating: String
}
