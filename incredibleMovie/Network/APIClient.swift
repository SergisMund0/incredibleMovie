//
//  APIClient.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation
import Alamofire

final class APIClient {
    static func popularMovies(page: Int, completion: @escaping (_ entity: PopularMovies?, _ error: Error?) -> Void) {
        if let networkReachabilityManager = NetworkReachabilityManager(), !networkReachabilityManager.isReachable {
            completion(nil, NSError(domain: "Local", code: 99, userInfo: [NSLocalizedDescriptionKey: "It seems like you have no internet connection..."]))
        }

        Alamofire.request(APIRouter.popularMovies(page: page)).responseData { (responseData) in
            switch responseData.result {
            case .success:
                if let data = responseData.data {
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(PopularMovies.self, from: data)
                        completion(model, nil)
                    } catch let error {
                        print("Error decoding data: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
