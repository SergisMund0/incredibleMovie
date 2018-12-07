//
//  DashboardPresenter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation
import UIKit

final class DashboardPresenter: DashboardPresenterInjection {
    // MARK: - Public properties
    var view: DashboardViewInjection?
    var interactor: DashboardInteractorInjection?
    
    // MARK: - Private properties
    
    // Indicates the actual page in the server
    private var currentPage = 1
    // Indicates the total pages in the server
    private var totalPages = 0
    // Indicates if there is a server request in progress
    private var isFetchInProgress = false
    // This flag indicates if the content is being filtered
    private var filteredContent = false
    // This variable represents the content which the user will be able to see in the dashboard
    private var filteredMoviewCells = [MovieCellModel]()
    // This variable represents the total movies retrieved from the server
    private var totalMoviewCells = [MovieCellModel]()
    
    private func showErrorScene(errorDescription: String) {
        let errorViewModel = ErrorViewInjectionModel(subtitle: errorDescription)
        
        guard let view = view as? UIViewController,
            let errorViewController = (ErrorRouter.setup(errorViewModel: errorViewModel) as? UIViewController) else {
                return
        }
        
        view.present(errorViewController, animated: true, completion: nil)
    }
}

// MARK: - DashboardViewDelegate
extension DashboardPresenter: DashboardViewDelegate {
    func viewDidLoad(dateRange: DateRange) {
        popularMovies(page: currentPage, dateRange: dateRange)
    }
    
    func viewDidScrollToBottom(dateRange: DateRange) {
        // If the content is not being filtered and there is more pages to load
        if !filteredContent, currentPage < totalPages {
            popularMovies(page: currentPage, dateRange: dateRange)
        }
    }
    
    func sliderDidEndEditing(rangeDate: DateRange) {
        filteredContent = true
        // If there is content to filter
        if let filteredContent = filterContent(totalMoviewCells, rangeDate: rangeDate) {
            view?.viewDidReceiveUpdates(dashboardInjectionModel: filteredContent)
        }
    }
    
    func didSelectItem(_ model: DashboardDelegateModel) {
        guard let detailViewController = DetailRouter.setup(movieCellModel: model.selectedMovieCellModel) as? UIViewController,
            let viewController = view as? UIViewController else {
                return
        }
        
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func scrollViewWillBeginDragging() {
        // Once the scroll starts again we need to reset the flag
        filteredContent = false
    }
}

// MARK: - Helpers
extension DashboardPresenter {
    private func popularMovies(page: Int, dateRange: DateRange) {
        guard let interactor = interactor, let view = view, !isFetchInProgress else { return }
        
        view.showLoader(true)
        isFetchInProgress = true
        
        interactor.popularMovies(page: page) { [unowned self] (popularMovies, error) in
            view.showLoader(false)
            self.isFetchInProgress = false
            
            if let error = error {
                self.showErrorScene(errorDescription: error.localizedDescription)
            }
            
            if let popularMovies = popularMovies {
                self.currentPage += 1
                self.totalPages = popularMovies.totalPages
                
                self.bindMovies(popularMovies)
                self.updateViewState(dateRange: dateRange)
            }
        }
    }
    
    private func bindMovies(_ popularMovies: PopularMovies) {
        for movie in popularMovies.results {
            if let backgroundImageURL = movie.backdropPath {
                let movieInjectionCell = MovieCellModel(backgroundImageURL: backgroundImageURL, title: movie.name, releaseDate: movie.firstAirDate, backgroundImageData: nil, overviewContent: movie.overview, rating: "\(movie.popularity)")
                self.totalMoviewCells.append(movieInjectionCell)
            }
        }
    }
    
    private func updateViewState(dateRange: DateRange) {
        guard let interactor = interactor, let view = view else { return }
        
        var currentStringDates = [String]()
        for movieCell in totalMoviewCells {
            currentStringDates.append(movieCell.releaseDate)
        }
        
        let rangeDate = interactor.getDateRange(from: currentStringDates)
        let filterViewModel = FilterViewModel(leadingValue: rangeDate.minDate, trailingValue: rangeDate.maxDate)
        let dashboardInjectionModel = DashboardInjectionModel(filterViewModel: filterViewModel, movieCellModel: totalMoviewCells)
        
        if currentPage == 1 {
            view.viewDidReceiveUpdates(dashboardInjectionModel: dashboardInjectionModel)
        } else {
            if let filteredContent = filterContent(totalMoviewCells, rangeDate: dateRange) {
                view.viewDidReceiveUpdates(dashboardInjectionModel: filteredContent)
            } else {
                view.viewDidReceiveUpdates(dashboardInjectionModel: dashboardInjectionModel)
            }
        }
    }
    
    private func filterContent(_ currentCells: [MovieCellModel], rangeDate: DateRange) -> DashboardInjectionModel? {
        // Delete filtered movies array's content
        filteredMoviewCells.removeAll()
        
        var dateDataModel = [String]()
        for element in totalMoviewCells {
            dateDataModel.append(element.releaseDate)
        }
        
        if let filteredDates = interactor?.filterStringDates(dateDataModel, byDateRange: rangeDate) {
            for filteredDate in filteredDates {
                let elementFiltered = totalMoviewCells.filter( { $0.releaseDate == filteredDate })
                filteredMoviewCells.append(contentsOf: elementFiltered)
            }
            
            let filterViewModel = FilterViewModel(leadingValue: rangeDate.minimumYearDate, trailingValue: rangeDate.maximumYearDate)
            let dashboardInjectionModel = DashboardInjectionModel(filterViewModel: filterViewModel, movieCellModel: filteredMoviewCells)
            
            return dashboardInjectionModel
        }
        
        return nil
    }
}
