//
//  DashboardInteractor.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

final class DashboardInteractor {
}

extension DashboardInteractor: DashboardInteractorInjection {
    func popularMovies(page: Int, completion: @escaping (_ entity: PopularMovies?, _ error: Error?) -> Void) {
        APIClient.popularMovies(page: page) { (popularMovies, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let popularMovies = popularMovies {
                completion(popularMovies, nil)
            }
        }
    }
}
