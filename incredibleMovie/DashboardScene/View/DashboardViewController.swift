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
    // MARK: - Public properties
    var presenter: DashboardViewDelegate?
    var dashboardViewModel: DashboardInjectionModel?
    
    // MARK: - Private properties
    @IBOutlet weak private var filterView: FilterView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var filterViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var loadingView: LoadingView!
    @IBOutlet weak private var filterButton: UIButton!
    
    // We need to hold this value in order to send to the presenter
    private var currentDateRange = DateRange()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.viewDidLoad(dateRange: DateRange())
    }
    
    private func setup() {
        filterViewHeightConstraint.constant = 0
        tableView.delegate = self
        tableView.dataSource = self
        filterView.delegate = self
    }
    
    // MARK: - Actions
    
    /// When the user presses the bottom button, it animates the filter view
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        let dynamicConstant: CGFloat = filterViewHeightConstraint.constant == 100 ? 0 : 100

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.filterViewHeightConstraint.constant = dynamicConstant
            self.view.layoutIfNeeded()
        }) { (value) in
            let dynamicTitle = dynamicConstant == 100 ? "HIDE FILTER" : "SHOW FILTER"
            self.filterButton.setTitle(dynamicTitle, for: .normal)
        }
    }
}

// MARK: - DashboardViewInjection
extension DashboardViewController: DashboardViewInjection {
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel) {
        dashboardViewModel = dashboardInjectionModel
        tableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        loadingView.isHidden = !show
    }
}

// MARK: - FilterViewDelegate
extension DashboardViewController: FilterViewDelegate {
    func sliderDidEndEditing(minValue: String, maxValue: String) {
        currentDateRange = DateRange(minimumYearDate: minValue, maximumYearDate: maxValue)
        let dateRange = DateRange(minimumYearDate: minValue, maximumYearDate: maxValue)
        
        presenter?.sliderDidEndEditing(rangeDate: dateRange)
    }
}

// MARK: - TableView Datasource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dashboardViewModel = dashboardViewModel else { return 0 }
        
        return dashboardViewModel.movieCellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellResources.nibName, for: indexPath) as? MovieViewCell,
            var dashboardViewModel = dashboardViewModel else {
                return UITableViewCell()
        }
        
        let movieCellModel = dashboardViewModel.movieCellModel[indexPath.row]
        cell.setup(movieCellModel)
        
        if tableViewScrollIsAtTheBottom() {
            presenter?.viewDidScrollToBottom(dateRange: currentDateRange)
        }
        
        return cell
    }
}

// MARK: - TableView Delegate
extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var dashboardViewModel = dashboardViewModel,
            let presenter = presenter,
            let currentCell = tableView.cellForRow(at: indexPath) as? MovieViewCell else {
                return
        }
        
        dashboardViewModel.movieCellModel[indexPath.row].backgroundImageData = currentCell.backgroundImage?.image
        let dashboardDelegateModel = DashboardDelegateModel(selectedMovieCellModel: dashboardViewModel.movieCellModel[indexPath.row])
        
        presenter.didSelectItem(dashboardDelegateModel)
    }
}

// MARK: - UIScrollViewDelegate
extension DashboardViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        presenter?.scrollViewWillBeginDragging()
    }
}

// MARK: - Helpers
extension DashboardViewController {
    private func tableViewScrollIsAtTheBottom() -> Bool {
        return tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height)
    }
}
