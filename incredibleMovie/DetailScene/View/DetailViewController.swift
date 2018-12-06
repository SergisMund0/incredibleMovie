//
//  DetailViewController.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Public properties
    var presenter: DetailViewDelegate?
    
    // MARK: - Private properties
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var backgroundTitle: UILabel!
    @IBOutlet private weak var contentTitle: UILabel!
    @IBOutlet private weak var contentRating: UILabel!
    @IBOutlet private weak var contentDescription: UILabel!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.contentMode = .scaleAspectFill
        presenter?.viewDidLoad()
    }
}

// MARK: - DetailViewInjection
extension DetailViewController: DetailViewInjection {
    func viewDidReceiveUpdates(movieCellModel: MovieCellModel) {
        backgroundImage.image = movieCellModel.backgroundImageData
        backgroundTitle.text = movieCellModel.title
        contentTitle.text = movieCellModel.title
        contentRating.text = movieCellModel.rating
        contentDescription.text = movieCellModel.overviewContent
    }
}
