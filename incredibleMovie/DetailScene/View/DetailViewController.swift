//
//  DetailViewController.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var backgroundTitle: UILabel!
    @IBOutlet private weak var contentTitle: UILabel!
    @IBOutlet private weak var contentRating: UILabel!
    @IBOutlet private weak var contentDescription: UILabel!
    
    var presenter: DetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImage.contentMode = .scaleAspectFill
        presenter?.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: DetailViewInjection {
    func viewDidReceiveUpdates(movieCellModel: MovieCellModel) {
        print("estoy aqui")
        backgroundImage.image = movieCellModel.backgroundImageData
        backgroundTitle.text = movieCellModel.title
        contentTitle.text = movieCellModel.title
        contentRating.text = movieCellModel.rating
        contentDescription.text = movieCellModel.overviewContent
    }
}
