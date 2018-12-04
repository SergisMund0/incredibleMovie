//
//  DashboardRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DashboardRouter {
    
}

extension DashboardRouter: DashboardRouterInjection {
    static func setup(dashboardInjectionModel: String) -> UIViewController? {
        let navigationController = UIStoryboard.main.instantiateViewController(withIdentifier: "NavigationController")
        guard var view = navigationController.children.first as? DashboardViewInjection else { return nil }
        
        var presenter: DashboardPresenterInjection & DashboardViewDelegate = DashboardPresenter()
        let interactor: DashboardInteractorInjection = DashboardInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        
        return navigationController
    }
}
