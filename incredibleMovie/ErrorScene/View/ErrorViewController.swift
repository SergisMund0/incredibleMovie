//
//  ErrorViewController.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 06/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import Lottie

final class ErrorViewController: UIViewController {
    // MARK: - Private properties
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var animationView: UIView!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak var bottomButton: UIButton!
    
    var presenter: ErrorViewDelegate?
    private var errorViewModel: ErrorViewInjectionModel?
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
        setupLayout()
    }
    
    private func setupAnimation() {
        let lottieAnimationView = LOTAnimationView(name: ErrorResources.animationIdentifier)
        lottieAnimationView.frame = animationView.frame
        animationView.addSubview(lottieAnimationView)
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimationView.leadingAnchor.constraint(equalTo: animationView.leadingAnchor).isActive = true
        lottieAnimationView.trailingAnchor.constraint(equalTo: animationView.trailingAnchor).isActive = true
        lottieAnimationView.topAnchor.constraint(equalTo: animationView.topAnchor).isActive = true
        lottieAnimationView.bottomAnchor.constraint(equalTo: animationView.bottomAnchor).isActive = true
        lottieAnimationView.loopAnimation = true
        lottieAnimationView.contentMode = .scaleAspectFill
        
        lottieAnimationView.play()
    }
    
    private func setupLayout() {
        guard let errorViewModel = errorViewModel else { return }
        
        titleLabel.text = errorViewModel.title
        subtitleLabel.text = errorViewModel.subtitle
        bottomButton.setTitle(errorViewModel.bottomButtonTitle, for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func bottomButtonDidPress(_ sender: Any) {
        presenter?.bottomButtonDidPress()
    }
}

// MARK: - ErrorViewInjection
extension ErrorViewController: ErrorViewInjection {
    func viewDidReceiveUpdates(errorViewModel: ErrorViewInjectionModel) {
        self.errorViewModel = errorViewModel
    }
}
