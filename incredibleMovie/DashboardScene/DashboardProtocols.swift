//
//  DashboardProtocols.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit

protocol DashboardViewInjection {
    var presenter: DashboardViewDelegate? { get set }

    func initialDataDidLoad(dashboardInjectionModel: DashboardInjectionModel)
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel)
}

protocol DashboardViewDelegate {
    func viewDidLoad()
    func viewDidScrollToBottom()
    func didSelectItem(_ model: MovieCellModel)
    func filterDidFinish(_ model: DashboardInjectionModel)
}

protocol DashboardPresenterInjection {
    var view: DashboardViewInjection? { get set }
    var interactor: DashboardInteractorInjection? { get set }
}

protocol DashboardPresenterDelegate {
    
}

protocol DashboardInteractorInjection {
    func popularMovies(page: Int, completion: @escaping (_ entity: PopularMovies?, _ error: Error?) -> Void)
    func releaseDateRange(_ releaseDates: ReleaseDates) -> (minDate: String, maxDate: String) 
}

protocol DashboardRouterInjection {
    static func setup(dashboardInjectionModel: String) -> UIViewController?
}

protocol DashboardRotuerDelegate {
    
}
