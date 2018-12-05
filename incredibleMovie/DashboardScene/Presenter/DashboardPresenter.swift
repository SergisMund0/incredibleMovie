//
//  DashboardPresenter.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import Foundation
import UIKit

final class DashboardPresenter {
    var view: DashboardViewInjection?
    var interactor: DashboardInteractorInjection?
    
    private var currentPage = 1
    private var totalPages = 0
    private var currentReleaseDates = [String]()
}

extension DashboardPresenter: DashboardPresenterInjection {
}

extension DashboardPresenter: DashboardViewDelegate {
    func viewDidLoad() {
        popularMovies(page: currentPage)
    }
    
    func viewDidScrollToBottom() {
        if currentPage < totalPages {
            currentPage += 1
            popularMovies(page: currentPage)
        }
    }
    
    func didSelectItem(_ model: MovieCellModel) {
        guard let detailViewController = DetailRouter.setup(movieCellModel: model) else { return }
        
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func filterDidFinish(_ model: DashboardInjectionModel) {
        
    }
    
    private func popularMovies(page: Int) {
        guard let interactor = interactor else { return }
        
        interactor.popularMovies(page: page, completion: { [unowned self] (popularMovies, error) in
            if let error = error {
                
            }
            
            if let popularMovies = popularMovies {
                self.totalPages = popularMovies.totalPages
                
                var viewDataModel = [MovieCellModel]()
                var dates = [String]()
                
                for movie in popularMovies.results {
                    if let backgroundImageURL = movie.backdropPath {
                        let movieInjectionCell = MovieCellModel(backgroundImageURL: backgroundImageURL, title: movie.name, releaseDate: movie.firstAirDate, backgroundImageData: nil, overviewContent: movie.overview, rating: "\(movie.popularity)")
                        viewDataModel.append(movieInjectionCell)
                        dates.append(movie.firstAirDate)
                    }
                }
                
                let releaseDates = ReleaseDates(dates: dates)
                self.currentReleaseDates.append(contentsOf: releaseDates.dates)
                
                let rangeDates = interactor.releaseDateRange(ReleaseDates(dates: self.currentReleaseDates))
                
                let dashboardInjectionModel = DashboardInjectionModel(minimumDate: rangeDates.minDate, maximumDate: rangeDates.maxDate, movieCellModel: viewDataModel)

                if self.currentPage == 1 {
                    self.view?.initialDataDidLoad(dashboardInjectionModel: dashboardInjectionModel)
                } else {
                    self.view?.viewDidReceiveUpdates(dashboardInjectionModel: dashboardInjectionModel)
                }
            }
        })
    }
}
