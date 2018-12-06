//
//  LoadingView.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 05/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {
    // MARK: - Public properties
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var loaderView: UIView!
    
    // MARK: - UIView
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(LoadingResources.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        let animationView = LOTAnimationView(name: LoadingResources.animationIdentifier)
        animationView.frame = loaderView.frame
        loaderView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.leadingAnchor.constraint(equalTo: loaderView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: loaderView.trailingAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: loaderView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: loaderView.bottomAnchor).isActive = true
        animationView.loopAnimation = true
        
        animationView.play()
    }
}
