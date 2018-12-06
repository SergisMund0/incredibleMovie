//
//  String.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 06/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

extension String {
    /// Convert a string to a Date object.
    ///
    /// - Parameter format: The format to apply. It should respect the ISO date formats
    /// - Returns: Date object
    func toDate(format: String = "yyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("The format isn't correct.")
        }
        
        return date
    }
}
