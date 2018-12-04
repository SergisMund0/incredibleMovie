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
    static func setup(movieCellViewModel: MovieCellViewModel) -> UIViewController? {
        guard var view = UIStoryboard.main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewInjection else { return nil }
        
        var presenter: DetailPresenterInjection & DetailViewDelegate = DetailPresenter()
        let interactor: DetailInteractorInjection = DetailInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.movieCellViewModel = movieCellViewModel
        
        return view as? UIViewController
    }
}


//let navigationController = UIStoryboard.main.instantiateViewController(withIdentifier: "NavigationController")
//guard var view = navigationController.children.first as? DashboardViewInjection else { return nil }
//
//var presenter: DashboardPresenterInjection & DashboardViewDelegate = DashboardPresenter()
//let interactor: DashboardInteractorInjection = DashboardInteractor()
//
//view.presenter = presenter
//presenter.view = view
//presenter.interactor = interactor
//
//return navigationController
