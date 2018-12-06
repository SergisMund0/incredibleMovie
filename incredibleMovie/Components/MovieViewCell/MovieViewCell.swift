//
//  MovieViewCell.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import AlamofireImage

final class MovieViewCell: UITableViewCell {
    // MARK: - Public properties
    @IBOutlet weak var backgroundImage: UIImageView!
    
    // MARK: - Private properties
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    
    // MARK: - UIView
    override func awakeFromNib() {
        commonInit()
    }
    
    private func commonInit() {
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - Public functions
    func setup(_ movieCellModel: MovieCellModel) {
        titleLabel.text = movieCellModel.title
        subtitleLabel.text = movieCellModel.releaseDate
        setupBackgroundImage(urlString: movieCellModel.backgroundImageURL)
    }
    
    // MARK: - Private functions
    private func setupBackgroundImage(urlString: String) {
        if let url = URL(string: APIRouter.fetchImage(path: urlString, imageSize: .normal).path) {
            backgroundImage.af_setImage(withURL: url)
        }
    }
}
