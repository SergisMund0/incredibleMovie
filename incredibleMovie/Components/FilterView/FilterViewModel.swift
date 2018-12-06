//
//  FilterViewModel.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 05/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

struct FilterViewModel {
    let leadingTitle, trailingTitle: String
    let leadingValue, trailingValue: CGFloat

    init(leadingTitle: String = FilterResources.minimumYearTitleString,
         trailingTitle: String = FilterResources.maximumYearTitleString,
         leadingValue: String = FilterResources.minimumYearNumberString,
         trailingValue: String = FilterResources.maximumYearNumberString) {

        self.leadingTitle = leadingTitle
        self.trailingTitle = trailingTitle
        
        // Apply default value if operation didn't success
        if let leadingNumberValue = NumberFormatter().number(from: leadingValue) {
            self.leadingValue = CGFloat(truncating: leadingNumberValue)
        } else {
            self.leadingValue = FilterResources.minimumYearNumber
        }
        
        if let trailingNumberValue = NumberFormatter().number(from: trailingValue) {
            self.trailingValue = CGFloat(truncating: trailingNumberValue)
        } else {
            self.trailingValue = FilterResources.maximumYearNumber
        }
    }
}
