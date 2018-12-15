//
//  DashboardRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class DashboardRouter: DashboardRouterInjection {
    static func setup() -> UIViewController? {
        let navigationController = UIStoryboard.main.instantiateViewController(withIdentifier: "NavigationController")
        guard let view = navigationController.children.first as? DashboardViewInjection else { return nil }
        
        let interactor: DashboardInteractorInjection = DashboardInteractor()
        let presenter: DashboardPresenterInjection & DashboardViewDelegate = DashboardPresenter(view: view, interactor: interactor)
        
        view.presenter = presenter
        
        return navigationController
    }
}
