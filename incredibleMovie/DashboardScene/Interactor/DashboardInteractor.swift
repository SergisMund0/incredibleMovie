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
    
    func releaseDateRange(_ releaseDates: ReleaseDates) -> (minDate: String, maxDate: String) {
        var datesFiltered = [Date]()
        
        for releaseDate in releaseDates.dates {
            if let formattedDate = formatStringToDate(releaseDate) {
                datesFiltered.append(formattedDate)
            }
        }
        
        if let maxDate = datesFiltered.max(),
            let minDate = datesFiltered.min() {
            
            return (minDate: getYearFromDate(minDate), maxDate: getYearFromDate(maxDate))
        }
        
        return (minDate: "", maxDate: "")
    }
    
    private func formatStringToDate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: string)
    }
    
    private func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
    
    private func getYearFromDate(_ date: Date) -> String {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        return "\(year)"
    }
}

struct ReleaseDates {
    let dates: [String]
}
