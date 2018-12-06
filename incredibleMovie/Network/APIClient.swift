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
        Alamofire.request(APIRouter.popularMovies(page: page)).responseData { (responseData) in
            switch responseData.result {
            case .success:
                let jsonDecoder = JSONDecoder()
                if let data = responseData.data {
                    
                    do {
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(PopularMovies.self, from: data)
                        completion(model, nil)
                    } catch let error {
                        print(error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
