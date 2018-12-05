//
//  DashboardTableViewController.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 04/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import AlamofireImage

final class DashboardViewController: UIViewController {
    var presenter: DashboardViewDelegate?
    var movieCellModel: [MovieCellModel]?
    
    @IBOutlet weak private var filterView: FilterView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var filterViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        filterView.delegate = self
        presenter?.viewDidLoad()
    }
    
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        if filterViewHeightConstraint.constant == 100 {
            let animator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
                self.filterViewHeightConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            
            animator.startAnimation()
        } else {
            let animator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
                self.filterViewHeightConstraint.constant = 100
                self.view.layoutIfNeeded()
            }
            
            animator.startAnimation()
        }
    }
}

// MARK: - TableView Datasource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCellModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell,
            let viewModel = movieCellModel {
            if let url = URL(string: "https://image.tmdb.org/t/p/w1280/" + viewModel[indexPath.row].backgroundImageURL) {
                cell.backgroundImage.af_setImage(withURL: url)
            }
            
            cell.titleLabel.text = viewModel[indexPath.row].title
            cell.subtitleLabel.text = viewModel[indexPath.row].releaseDate
            
            if indexPath.row == viewModel.count-1 {
                presenter?.viewDidScrollToBottom()
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - TableView Delegate
extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var movieCellModel = movieCellModel,
            let presenter = presenter,
        let currentCell = tableView.cellForRow(at: indexPath) as? MovieViewCell else { return }
        
        movieCellModel[indexPath.row].backgroundImageData = currentCell.backgroundImage?.image
        presenter.didSelectItem(movieCellModel[indexPath.row])
    }
}

extension DashboardViewController: DashboardViewInjection {
    func initialDataDidLoad(dashboardInjectionModel: DashboardInjectionModel) {
        movieCellModel = dashboardInjectionModel.movieCellModel
        let filterViewModel = FilterViewModel(leadingValue: dashboardInjectionModel.minimumDate, trailingValue: dashboardInjectionModel.maximumDate)
        filterView.setup(viewModel: filterViewModel)
        
        tableView.reloadData()
    }
    
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel) {
        movieCellModel?.append(contentsOf: dashboardInjectionModel.movieCellModel)
        let filterViewModel = FilterViewModel(leadingValue: dashboardInjectionModel.minimumDate, trailingValue: dashboardInjectionModel.maximumDate)
        filterView.setup(viewModel: filterViewModel)
        
        tableView.reloadData()
    }
}

extension DashboardViewController: FilterViewDelegate {
    func sliderDidEndEditing(minValue: String, maxValue: String) {
        
    }
}
