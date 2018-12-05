//
//  DetailPresenter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation

final class DetailPresenter {
    var view: DetailViewInjection?
    var interactor: DetailInteractorInjection?
    
    var movieCellModel: MovieCellModel?
}

extension DetailPresenter: DetailPresenterInjection {
    
}

extension DetailPresenter: DetailViewDelegate {
    func viewDidLoad() {
        guard let movieCellModel = movieCellModel else { return }
        
        view?.viewDidReceiveUpdates(movieCellModel: movieCellModel)
    }
}
