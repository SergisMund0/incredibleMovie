//
//  DashboardTableViewController.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import AlamofireImage

final class DashboardTableViewController: UITableViewController {
    var presenter: DashboardViewDelegate?
    var movieCellViewModel: [MovieCellViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellViewModel?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell,
            let viewModel = movieCellViewModel {
            if let url = URL(string: "https://image.tmdb.org/t/p/w1280/" + viewModel[indexPath.row].backgroundImageURL) {
                cell.backgroundImage.af_setImage(withURL: url)
            }
            
            cell.titleLabel.text = viewModel[indexPath.row].title
            
            if indexPath.row == viewModel.count-1 {
                presenter?.viewDidScrollToBottom()
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension DashboardTableViewController: DashboardViewInjection {
    func initialDataDidLoad(dashboardInjectionModel: DashboardInjectionModel) {
        movieCellViewModel = dashboardInjectionModel.viewDataModel
        tableView.reloadData()
    }
    
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel) {
        movieCellViewModel?.append(contentsOf: dashboardInjectionModel.viewDataModel)
        tableView.reloadData()
    }
}
