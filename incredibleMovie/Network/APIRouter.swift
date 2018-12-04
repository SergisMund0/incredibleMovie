//
//  APIRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case popularMovies(page: Int)
    case fetchImage(path: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .popularMovies:
            return .get
        case .fetchImage:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .popularMovies(let page):
            return "/tv/popular?\(APIConstants.APIParameterKey.apiKey)=\(APIConstants.Server.apiKey)&\(APIConstants.APIParameterKey.page)=\(page)"
        case .fetchImage(let path):
            return "/t/p/original/\(path)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .popularMovies:
            return nil
        case .fetchImage:
            return nil
        }
    }
    
    // MARK: - URLRequest
    func asURLRequest() throws -> URLRequest {
        let stringURL = (APIConstants.Server.baseURL + path).removingPercentEncoding
        
        guard let url = try stringURL?.asURL() else {
            throw NSError(domain: LocalErrors.badlyFormatted.domain, code: LocalErrors.badlyFormatted.code, userInfo: nil)
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Headers configuration
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
