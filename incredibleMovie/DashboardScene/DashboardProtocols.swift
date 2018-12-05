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

    // We need a separate method in order to create the initial content in the Dashboard
    func initialDataDidLoad(dashboardInjectionModel: DashboardInjectionModel)
    // Once the initial content is loaded, the view receives the updates through this method
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel)
}

protocol DashboardViewDelegate {
    func viewDidLoad()
    
    // Each time that the user arrives to the bottom a event
    // is fired. (We use this for the infinite scrolling with pagination)
    func viewDidScrollToBottom()
    
    func didSelectItem(_ model: DashboardDelegateModel)
    
    // User selected a filter
    func filterDidFinish(_ model: DashboardDelegateModel)
}

protocol DashboardPresenterInjection {
    var view: DashboardViewInjection? { get set }
    var interactor: DashboardInteractorInjection? { get set }
}

protocol DashboardInteractorInjection {
    
    /// Retrieve popular movies from "The Movie Database API"
    ///
    /// - Parameters:
    ///   - page: Page where find the movies
    ///   - completion: One of the properties will have content depending of the server response
    func popularMovies(page: Int, completion: @escaping (_ entity: PopularMovies?, _ error: Error?) -> Void)
    
    /// <#Description#>
    ///
    /// - Parameter releaseDates: <#releaseDates description#>
    /// - Returns: <#return value description#>
    func releaseDateRange(_ releaseDates: ReleaseDates) -> (minDate: String, maxDate: String)
}

protocol DashboardRouterInjection {
    static func setup() -> UIViewController?
}
