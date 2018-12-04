//
//  APIConstants.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

struct APIConstants {
    struct Server {
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKey = "b93afcef54efbfc201e00ee14d104110"
    }
    
    struct APIParameterKey {
        static let apiKey = "api_key"
        static let query = "query"
        static let page = "page"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
