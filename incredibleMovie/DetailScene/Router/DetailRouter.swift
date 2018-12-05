//
//  DetailRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DetailRouter {
    
}

extension DetailRouter: DetailRouterInjection {
    static func setup(movieCellModel: MovieCellModel) -> UIViewController? {
        guard var view = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewInjection else { return nil }
        
        var presenter: DetailPresenterInjection & DetailViewDelegate = DetailPresenter()
        let interactor: DetailInteractorInjection = DetailInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.movieCellModel = movieCellModel
        
        return view as? UIViewController
    }
}
