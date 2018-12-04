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
    
    func didSelectItem(_ model: MovieCellViewModel) {
        guard let detailViewController = DetailRouter.setup(movieCellViewModel: model) else { return }
        
        if let viewController = view as? UITableViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    private func popularMovies(page: Int) {
        interactor?.popularMovies(page: page, completion: { [unowned self] (popularMovies, error) in
            if let error = error {
                
            }
            
            if let popularMovies = popularMovies {
                self.totalPages = popularMovies.totalPages
                
                var viewDataModel = [MovieCellViewModel]()
                
                for movie in popularMovies.results {
                    if let backgroundImageURL = movie.backdropPath {
                        let movieInjectionCell = MovieCellViewModel(title: movie.name, backgroundImageURL: backgroundImageURL, subtitle: movie.overview, rating: "\(movie.popularity)", date: movie.firstAirDate, imageData: nil)
                        viewDataModel.append(movieInjectionCell)
                    }
                }
                
                let dashboardInjectionModel = DashboardInjectionModel(viewDataModel: viewDataModel)
                
                if self.currentPage == 1 {
                    self.view?.initialDataDidLoad(dashboardInjectionModel: dashboardInjectionModel)
                } else {
                    self.view?.viewDidReceiveUpdates(dashboardInjectionModel: dashboardInjectionModel)
                }
            }
        })
    }
}
