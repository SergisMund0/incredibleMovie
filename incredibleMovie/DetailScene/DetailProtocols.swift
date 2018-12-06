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
    
    func viewDidReceiveUpdates(movieCellModel: MovieCellModel)
}

protocol DetailViewDelegate {
    func viewDidLoad()
}

protocol DetailPresenterInjection {
    var view: DetailViewInjection? { get set }
    var movieCellModel: MovieCellModel? { get set }
}

protocol DetailRouterInjection {
    static func setup(movieCellModel: MovieCellModel) -> DetailViewInjection?
}
