//
//  Date.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 06/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

extension Date {
    /// Convert Date to a string.
    ///
    /// - Parameter format: The format to apply. It should respect the ISO date formats
    /// - Returns: String
    func toString(format: String = "yyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    var yearString: String {
        get {
            let calendar = Calendar.current
            return "\(calendar.component(.year, from: self))"
        }
    }
}
