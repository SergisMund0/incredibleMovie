//
//  FilterView.swift
//  incredibleMovie
//
//  Created by Sergio Garre on 05/12/2018.
//  Copyright © 2018 Sergio Garre. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol FilterViewDelegate: class {
    func sliderDidEndEditing(minValue: String, maxValue: String)
}

final class FilterView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var leadingLabel: UILabel!
    @IBOutlet weak private var trailingLabel: UILabel!
    @IBOutlet weak private var rangeSlider: RangeSeekSlider!
    
    private var minimumSelectedValue = "0"
    private var maximumSelectedValue = "0"
    
    weak var delegate: FilterViewDelegate?
    
    private var filterViewModel: FilterViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        rangeSlider.delegate = self
    }
    
    override func awakeFromNib() {
        setupSlider()
    }

    func setup(viewModel: FilterViewModel) {
        filterViewModel = viewModel
        setupSlider()
    }
    
    private func setupSlider() {
        guard let filterViewModel = filterViewModel else { return }
        
        leadingLabel.text = filterViewModel.leadingTitle
        trailingLabel.text = filterViewModel.trailingTitle
        rangeSlider.minValue = filterViewModel.leadingValue
        rangeSlider.maxValue = filterViewModel.trailingValue
        rangeSlider.selectedMinValue = filterViewModel.leadingValue
        rangeSlider.selectedMaxValue = filterViewModel.trailingValue
    }
}

extension FilterView: RangeSeekSliderDelegate {
    func didEndTouches(in slider: RangeSeekSlider) {
        delegate?.sliderDidEndEditing(minValue: minimumSelectedValue, maxValue: maximumSelectedValue)
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        minimumSelectedValue = "\(Int(ceil(minValue)))"
        return minimumSelectedValue
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue: CGFloat) -> String? {
        maximumSelectedValue = "\(Int(ceil(stringForMaxValue)))"
        return maximumSelectedValue
    }
}
