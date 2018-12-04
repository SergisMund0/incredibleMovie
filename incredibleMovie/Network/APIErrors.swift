//
//  APIErrors.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

enum LocalErrors {
    case badlyFormatted
    
    var domain: String {
        switch self {
        case .badlyFormatted:
            return "The URL was not formatted properly"
        }
    }
    
    var code: Int {
        switch self {
        case .badlyFormatted:
            return 999
        }
    }
}
