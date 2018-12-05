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
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.viewDidLoad()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        filterView.delegate = self
    }
    
    // Call this function when the view needs to update its content
    private func updateViewState() {
        guard let dashboardViewModel = dashboardViewModel else { return }
        
        filterView.setup(viewModel: dashboardViewModel.filterViewModel)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    /// When the user presses the bottom button, it animates the filter view
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        let dynamicConstant: CGFloat = filterViewHeightConstraint.constant == 100 ? 0 : 100
        
        let animator = UIViewPropertyAnimator(duration: 0.25, curve: .linear) {
            self.filterViewHeightConstraint.constant = dynamicConstant
            self.view.layoutIfNeeded()
        }

        animator.startAnimation()
    }
}

// MARK: - DashboardViewInjection
extension DashboardViewController: DashboardViewInjection {
    func initialDataDidLoad(dashboardInjectionModel: DashboardInjectionModel) {
        // Creates the initial content
        dashboardViewModel = dashboardInjectionModel
        updateViewState()
    }
    
    func viewDidReceiveUpdates(dashboardInjectionModel: DashboardInjectionModel) {
        // Add content to the existing model
        dashboardViewModel?.movieCellModel.append(contentsOf: dashboardInjectionModel.movieCellModel)
        updateViewState()
    }
}

// MARK: - FilterViewDelegate
extension DashboardViewController: FilterViewDelegate {
    func sliderDidEndEditing(minValue: String, maxValue: String) {
        
    }
}

// MARK: - TableView Datasource
extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dashboardViewModel = dashboardViewModel else { return 0 }
        
        return dashboardViewModel.movieCellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as? MovieViewCell,
            let dashboardViewModel = dashboardViewModel else {
                return UITableViewCell()
        }
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w1280/" + dashboardViewModel.movieCellModel[indexPath.row].backgroundImageURL) {
            cell.backgroundImage.af_setImage(withURL: url)
        }
        
        cell.titleLabel.text = dashboardViewModel.movieCellModel[indexPath.row].title
        cell.subtitleLabel.text = dashboardViewModel.movieCellModel[indexPath.row].releaseDate
        
        // If the user arrived to the bottom and there is more content to load, call the presenter
        // in order to get the additional data
        if indexPath.row == dashboardViewModel.movieCellModel.count-1 {
            presenter?.viewDidScrollToBottom()
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
        let dashboardDelegateModel = DashboardDelegateModel(minimumSelectedDate: "", maximumSelectedDate: "", selectedMovieCellModel: dashboardViewModel.movieCellModel[indexPath.row])
        
        presenter.didSelectItem(dashboardDelegateModel)
    }
}
