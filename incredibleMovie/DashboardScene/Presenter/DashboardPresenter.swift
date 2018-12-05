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
    private var currentPage = 1
    private var totalPages = 0
    private var currentReleaseDates = [String]()
}

// MARK: - DashboardViewDelegate
extension DashboardPresenter: DashboardViewDelegate {
    func didSelectItem(_ model: DashboardDelegateModel) {
        guard let detailViewController = DetailRouter.setup(movieCellModel: model.selectedMovieCellModel),
        let viewController = view as? UIViewController else {
            return
        }
        
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func filterDidFinish(_ model: DashboardDelegateModel) {
        
    }
    
    func viewDidLoad() {
        popularMovies(page: currentPage)
    }
    
    func viewDidScrollToBottom() {
        if currentPage < totalPages {
            currentPage += 1
            popularMovies(page: currentPage)
        }
    }
    
    private func popularMovies(page: Int) {
        guard let interactor = interactor else { return }
        
        interactor.popularMovies(page: page, completion: { [unowned self] (popularMovies, error) in
            if let error = error {
                
            }
            
            if let popularMovies = popularMovies {
                self.totalPages = popularMovies.totalPages
                
                var movieCellModel = [MovieCellModel]()
                var dates = [String]()
                
                for movie in popularMovies.results {
                    if let backgroundImageURL = movie.backdropPath {
                        let movieInjectionCell = MovieCellModel(backgroundImageURL: backgroundImageURL, title: movie.name, releaseDate: movie.firstAirDate, backgroundImageData: nil, overviewContent: movie.overview, rating: "\(movie.popularity)")
                        movieCellModel.append(movieInjectionCell)
                        dates.append(movie.firstAirDate)
                    }
                }
                
                let releaseDates = ReleaseDates(dates: dates)
                self.currentReleaseDates.append(contentsOf: releaseDates.dates)
                
                let rangeDates = interactor.releaseDateRange(ReleaseDates(dates: self.currentReleaseDates))
                
                let filterViewModel = FilterViewModel(leadingValue: rangeDates.minDate, trailingValue: rangeDates.maxDate)
                let dasboardInjectionModel = DashboardInjectionModel(filterViewModel: filterViewModel, movieCellModel: movieCellModel)

                if self.currentPage == 1 {
                    self.view?.initialDataDidLoad(dashboardInjectionModel: dasboardInjectionModel)
                } else {
                    self.view?.viewDidReceiveUpdates(dashboardInjectionModel: dasboardInjectionModel)
                }
            }
        })
    }
}
