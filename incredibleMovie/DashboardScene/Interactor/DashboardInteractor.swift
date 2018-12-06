//
//  DashboardInteractor.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

final class DashboardInteractor: DashboardInteractorInjection {
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
    
    func getDateRange(from stringDates: [String]) -> DateRangeType {
        // Apply format in order to be able to make the operations
        var arrayDates = [Date]()
        
        for stringDate in stringDates {
            arrayDates.append(stringDate.toDate())
        }
        
        // Gets the dates maximum and minimum from array
        if let maximumDate = arrayDates.max(),
            let minimumDate = arrayDates.min() {
            
            return (minDate: minimumDate.yearString, maxDate: maximumDate.yearString)
        }
        
        return (minDate: FilterResources.minimumYearNumberString, maxDate: FilterResources.maximumYearNumberString)
    }
    
    func filterStringDates(_ stringDates: [String], byDateRange dateRange: DateRange) -> ArrayStringDates? {
        // Apply format in order to be able to make the operations
        var arrayDates = [Date]()
        let minimumDateFormatted = dateRange.minimumYearDate.toDate()
        let maximumDateFormatted = dateRange.maximumYearDate.toDate()
        
        for stringDate in stringDates {
            arrayDates.append(stringDate.toDate())
        }
        
        // Apply the filter
        let filteredArrayDates = arrayDates.filter { ($0 >= minimumDateFormatted && $0 <= maximumDateFormatted) }
        
        // Format again to return the values
        var stringArrayDates = [String]()
        for filteredArrayDate in filteredArrayDates {
            stringArrayDates.append(filteredArrayDate.toString())
        }
        
        if stringArrayDates.count>0 {
            return stringArrayDates
        }
        return nil
    }
}
