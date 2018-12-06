//
//  ErrorRouter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 06/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

final class ErrorRouter: ErrorRouterInjection {
    static func setup(errorViewModel: ErrorViewInjectionModel) -> ErrorViewInjection? {
        guard var errorViewInjection = UIStoryboard.main.instantiateViewController(withIdentifier: ErrorResources.nibName) as? ErrorViewInjection else {
            return nil
        }
        
        var presenter: ErrorPresenterInjection & ErrorViewDelegate = ErrorPresenter()
        presenter.view = errorViewInjection
        errorViewInjection.presenter = presenter
        errorViewInjection.viewDidReceiveUpdates(errorViewModel: errorViewModel)
        
        return errorViewInjection
    }
}
