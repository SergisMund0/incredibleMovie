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
        let defaultDateRangeType = (minDate: FilterResources.minimumYearNumberString, maxDate: FilterResources.maximumYearNumberString)
        
        let stringDatesAreValid = stringDates.allSatisfy({isStringDateFormatValid($0) == true})
        if !stringDatesAreValid {
            return defaultDateRangeType
        }
        
        // 1. Apply format in order to be able to make the operations
        var arrayDates = [Date]()
        for stringDate in stringDates {
            arrayDates.append(stringDate.toDate())
        }
        
        // 2. Gets the dates maximum and minimum from array
        if let maximumDate = arrayDates.max(),
            let minimumDate = arrayDates.min(),
            stringDatesAreValid {
            
            return (minDate: minimumDate.yearString, maxDate: maximumDate.yearString)
        }
        
        return defaultDateRangeType
    }
    
    func filterStringDates(_ stringDates: [String], byDateRange dateRange: DateRange) -> ArrayStringDates? {
        // 1. Check if string dates and date range are valid
        let stringDatesAreValid = stringDates.allSatisfy({isStringDateFormatValid($0) == true})
        if !isDateRangeValid(dateRange) || !stringDatesAreValid {
            return nil
        }
        
        // 2. Apply format in order to be able to make the operations
        var arrayDates = [Date]()
        let minimumDateFormatted = dateRange.minimumYearDate.toDate()
        let maximumDateFormatted = dateRange.maximumYearDate.toDate()
        
        for stringDate in stringDates {
            arrayDates.append(stringDate.toDate())
        }
        
        // 3. Apply the filter
        let filteredArrayDates = arrayDates.filter { ($0 >= minimumDateFormatted && $0 <= maximumDateFormatted) }
        
        // 4. Format again to return the values
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

// MARK: - Helpers
extension DashboardInteractor {
    internal func isStringDateFormatValid(_ stringDate: String) -> Bool {
        // Regarding to the BE contract, the string should have this format: "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 1. Count the characters in order to avoid crashes in the follow lines
        if stringDate.count>10 || stringDate.count<10 {
            return false
        }
        
        let firstCharacter = stringDate[stringDate.index(stringDate.startIndex, offsetBy: 4)]
        let secondCharacter = stringDate[stringDate.index(stringDate.startIndex, offsetBy: 7)]
        
        // 2. The special separator characters should match with the previous format
        if firstCharacter != "-" || secondCharacter != "-" {
            return false
        }
        
        // 3. The conversion to a Date object should be fine
        guard let _ = dateFormatter.date(from: stringDate) else {
            return false
        }
        
        return true
    }
    
    internal func isDateRangeValid(_ dateRange: DateRange) -> Bool {
        // 1. Number of characters are 10 because this format: '2018-12-12'
        if dateRange.minimumYearDate.count>10 || dateRange.minimumYearDate.count<10 {
            return false
        }
        
        // 2. Evaluate if the format is correct
        if !isStringDateFormatValid(dateRange.minimumYearDate) || !isStringDateFormatValid(dateRange.maximumYearDate) {
            return false
        }
        
        // 3. Get the year from the dates. offsetBy it's -6 because it is starting from the end of the string
        let index = dateRange.minimumYearDate.index(dateRange.minimumYearDate.endIndex, offsetBy: -6)
        let minimumYearSubstring = dateRange.minimumYearDate[..<index]
        let maximumYearSubstring = dateRange.maximumYearDate[..<index]
        
        if let min = (Int(minimumYearSubstring)), let max = (Int(maximumYearSubstring)) {
            if min > max {
                return false
            }
        }
        
        return true
    }
}
