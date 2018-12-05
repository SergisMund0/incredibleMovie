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

    init(leadingTitle: String = "Minimum Year",
         trailingTitle: String = "Maximum Year",
         leadingValue: String,
         trailingValue: String) {

        self.leadingTitle = leadingTitle
        self.trailingTitle = trailingTitle
        
        if let leadingNumberValue = NumberFormatter().number(from: leadingValue) {
            self.leadingValue = CGFloat(truncating: leadingNumberValue)
        } else {
            self.leadingValue = 1930
        }
        
        if let trailingNumberValue = NumberFormatter().number(from: trailingValue) {
            self.trailingValue = CGFloat(truncating: trailingNumberValue)
        } else {
            self.trailingValue = 2018
        }
    }
}
