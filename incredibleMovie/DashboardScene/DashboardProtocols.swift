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

    /// Notifies the view about state changes
    ///
    /// - Parameter dashboardInjectionModel: The actual view state for the updates
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel)
    
    /// Notifies the view to show the loading view
    ///
    /// - Parameter show: true if the view needs to show the loading view
    func showLoader(_ show: Bool)
}

protocol DashboardViewDelegate {
    func viewDidLoad(dateRange: DateRange)

    /// Notifies the presenter that the scroll
    /// reached the bottom of the view
    ///
    /// - Parameter dateRange: A range of dates to apply the filter
    func viewDidScrollToBottom(dateRange: DateRange)
    
    func didSelectItem(_ model: DashboardDelegateModel)

    /// Notifies the presenter to filter the current content
    ///
    /// - Parameter rangeDate: A range of dates to apply the filter
    func sliderDidEndEditing(rangeDate: DateRange)
    
    /// Notifies the presenter that the scroll started
    func scrollViewWillBeginDragging()
}

protocol DashboardPresenterInjection {
    var view: DashboardViewInjection? { get set }
    var interactor: DashboardInteractorInjection? { get set }
}

protocol DashboardInteractorInjection {
    typealias ArrayStringDates = [String]
    typealias DateRangeType = (minDate: String, maxDate: String)
    
    /// Retrieve popular movies from "The Movie Database API"
    ///
    /// - Parameters:
    ///   - page: Page where find the movies
    ///   - completion: One of the properties will have content depending of the server response
    func popularMovies(page: Int, completion: @escaping (_ entity: PopularMovies?, _ error: Error?) -> Void)
    
    /// This function returns a Date range
    ///
    /// - Parameter stringDates: String dates
    /// - Returns: A tuple with the minimum and maximum value
    func getDateRange(from stringDates: [String]) -> DateRangeType
    
    /// This function applies a filter to an array of dates and returns the array filtered
    ///
    /// - Parameters:
    ///   - stringDates: The array of strings to filter
    ///   - dateRange: A date range to apply
    /// - Returns: The array filtered
    func filterStringDates(_ stringDates: [String], byDateRange dateRange: DateRange) -> ArrayStringDates?
}

protocol DashboardRouterInjection {
    static func setup() -> UIViewController?
}
