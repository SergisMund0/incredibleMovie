//
//  DetailProtocols.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

protocol DetailViewInjection {
    var presenter: DetailViewDelegate? { get set }
    
    func viewDidReceiveUpdates(movieCellViewModel: MovieCellViewModel)
}

protocol DetailViewDelegate {
    func viewDidLoad()
}

protocol DetailPresenterInjection {
    var view: DetailViewInjection? { get set }
    var interactor: DetailInteractorInjection? { get set }
    var movieCellViewModel: MovieCellViewModel? { get set }
}

protocol DetailPresenterDelegate {
    
}

protocol DetailInteractorInjection {
    
}

protocol DetailRouterInjection {
    static func setup(movieCellViewModel: MovieCellViewModel) -> UIViewController?
}

protocol DetailRotuerDelegate {
    
}
