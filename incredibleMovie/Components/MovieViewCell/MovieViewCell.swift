//
//  MovieViewCell.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewCell: UITableViewCell {
    // MARK: - Public properties
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - UIView
    override func awakeFromNib() {
        backgroundImage.contentMode = .scaleAspectFill
    }
}
