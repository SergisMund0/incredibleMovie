//
//  DetailRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DetailRouter: DetailRouterInjection {
    static func setup(movieCellModel: MovieCellModel) -> DetailViewInjection? {
        guard var view = UIStoryboard.main.instantiateViewController(withIdentifier: DetailResources.nibName) as? DetailViewInjection else { return nil }
        var presenter: DetailPresenterInjection & DetailViewDelegate = DetailPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.movieCellModel = movieCellModel
        
        return view
    }
}
