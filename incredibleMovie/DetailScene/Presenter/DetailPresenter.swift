//
//  DetailPresenter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

final class DetailPresenter: DetailPresenterInjection {
    // MARK: - Public properties
    var view: DetailViewInjection?
    var movieCellModel: MovieCellModel?
}

// MARK: - DetailViewDelegate
extension DetailPresenter: DetailViewDelegate {
    func viewDidLoad() {
        guard let movieCellModel = movieCellModel else { return }
        
        view?.viewDidReceiveUpdates(movieCellModel: movieCellModel)
    }
}
