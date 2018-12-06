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
    // MARK: - Public properties
    weak var delegate: FilterViewDelegate?
    
    // MARK: - Private properties
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var leadingLabel: UILabel!
    @IBOutlet weak private var trailingLabel: UILabel!
    @IBOutlet weak private var rangeSlider: RangeSeekSlider!
    
    private var minimumSelectedValue = FilterResources.minimumYearNumberString
    private var maximumSelectedValue = FilterResources.maximumYearNumberString

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
        Bundle.main.loadNibNamed(FilterResources.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        rangeSlider.delegate = self
    }
    
    override func awakeFromNib() {
        setupSlider(FilterViewModel())
    }

    // MARK: - Public functions
    func setup(viewModel: FilterViewModel) {
        setupSlider(viewModel)
    }
    
    // MARK: - Private functions
    private func setupSlider(_ filterViewModel: FilterViewModel) {
        leadingLabel.text = filterViewModel.leadingTitle
        trailingLabel.text = filterViewModel.trailingTitle
        rangeSlider.minValue = filterViewModel.leadingValue
        rangeSlider.maxValue = filterViewModel.trailingValue
        rangeSlider.selectedMinValue = filterViewModel.leadingValue
        rangeSlider.selectedMaxValue = filterViewModel.trailingValue
    }
}

// MARK: - RangeSeekSliderDelegate
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
