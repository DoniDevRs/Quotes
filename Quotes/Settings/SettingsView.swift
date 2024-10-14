//
//  SettingsView.swift
//  QuotesApp
//
//  Created by Doni Silva on 26/08/24.
//

import Foundation
import UIKit

public protocol SettingsViewDelegate: AnyObject {
    func changeSwitch(_ sender: UISwitch)
    func changeValueSlider(_ sender: UISlider)
    func changeSegmentedValue(_ sender: UISegmentedControl)
}

final public class SettingsView: UIView {
    
    private enum Constants {
        static let autoChangeLabelText = "autoChangeLabelText".localized
        static let labelTimeIntervalText = "labelTimeIntervalText".localized
        static let labelColorSchemeText = "labelColorSchemeText".localized
        static let lightText = "lightText".localized
        static let darkText = "darkText".localized
        static let instructionText = "instructionText".localized
        static let labelInitialValueText = "5"
        static let labelFinalValueText = "30"
        static let changeAfterText = "changeAfterText".localized
        static let secondsText = "secondsText".localized
        static let separatorHeight: CGFloat = 1
        static let sliderMinimumValue: CFloat = 5
        static let sliderMaximumValue: CFloat = 30
        static let sliderDefaultValue: CFloat = 8
    }
    
    public weak var delegate: SettingsViewDelegate?
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var autoChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.autoChangeLabelText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        return label
    }()
    
    public lazy var switchAutoRefresh: UISwitch = {
        let switchAutoRefresh = UISwitch()
        switchAutoRefresh.translatesAutoresizingMaskIntoConstraints = false
        switchAutoRefresh.onTintColor = .appPrimary
        switchAutoRefresh.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
        return switchAutoRefresh
    }()
    
    private lazy var separatorSwitchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var labelTimeInterval: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.labelTimeIntervalText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        return label
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = SizeMetrics.medium
        return stackView
    }()
    
    private lazy var labelInitialValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.labelInitialValueText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        return label
    }()
    
    public lazy var sliderTimeInterval: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = Constants.sliderMinimumValue
        slider.maximumValue = Constants.sliderMaximumValue
        slider.value = Constants.sliderDefaultValue
        slider.minimumTrackTintColor = .appPrimary
        slider.addTarget(self, action: #selector(sliderAction(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var labelFinalValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.labelFinalValueText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        return label
    }()
    
    private lazy var separatorSliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var labelColorScheme: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.labelColorSchemeText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        return label
    }()
    
    public lazy var segmentedColorScheme: UISegmentedControl = {
        let items = [Constants.lightText, Constants.darkText]
        let segControl = UISegmentedControl(items: items)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.selectedSegmentIndex = .zero
        segControl.backgroundColor = .appPrimary
        segControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return segControl
    }()
    
    private lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.instructionText
        label.font = UIFont.systemFont(ofSize: FontSizeMetrics.body2)
        label.textColor = .appPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(autoChangeLabel)
        view.addSubview(switchAutoRefresh)
        view.addSubview(separatorSwitchView)
        view.addSubview(labelTimeInterval)
        view.addSubview(sliderStackView)
        view.addSubview(separatorSliderView)
        sliderStackView.addArrangedSubview(labelInitialValue)
        sliderStackView.addArrangedSubview(sliderTimeInterval)
        sliderStackView.addArrangedSubview(labelFinalValue)
        view.addSubview(labelColorScheme)
        view.addSubview(segmentedColorScheme)
        view.addSubview(instructionLabel)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        autoChangeLabel.topTo(view.safeAreaLayoutGuide.topAnchor, constant: SizeMetrics.medium2)
        autoChangeLabel.centerXTo(view.centerXAnchor)
        
        switchAutoRefresh.topTo(autoChangeLabel.bottomAnchor, constant: SizeMetrics.small)
        switchAutoRefresh.centerXTo(view.centerXAnchor)
        
        separatorSwitchView.topTo(switchAutoRefresh.bottomAnchor, constant: SizeMetrics.small)
        separatorSwitchView.leadingTo(view.leadingAnchor)
        separatorSwitchView.trailingTo(view.trailingAnchor)
        separatorSwitchView.height(Constants.separatorHeight)
        
        labelTimeInterval.topTo(separatorSwitchView.bottomAnchor, constant: SizeMetrics.medium)
        labelTimeInterval.centerXTo(view.centerXAnchor)
        
        sliderStackView.topTo(labelTimeInterval.bottomAnchor, constant: SizeMetrics.medium)
        sliderStackView.leadingTo(view.leadingAnchor, constant: SizeMetrics.medium2)
        sliderStackView.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        separatorSliderView.topTo(sliderStackView.bottomAnchor, constant: SizeMetrics.medium2)
        separatorSliderView.leadingTo(view.leadingAnchor)
        separatorSliderView.trailingTo(view.trailingAnchor)
        separatorSliderView.height(Constants.separatorHeight)
        
        labelColorScheme.topTo(separatorSliderView.bottomAnchor, constant: SizeMetrics.medium)
        labelColorScheme.centerXTo(view.centerXAnchor)
        
        segmentedColorScheme.topTo(labelColorScheme.bottomAnchor, constant: SizeMetrics.medium)
        segmentedColorScheme.leadingTo(view.leadingAnchor, constant: SizeMetrics.medium2)
        segmentedColorScheme.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        instructionLabel.leadingTo(view.leadingAnchor, constant: SizeMetrics.medium2)
        instructionLabel.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        instructionLabel.bottomTo(view.safeAreaLayoutGuide.bottomAnchor, constant: SizeMetrics.large)
        
    }
    
    @objc func switchAction(_ sender: UISwitch) {
        delegate?.changeSwitch(sender)
    }
    
    @objc func sliderAction(_ sender: UISlider) {
        delegate?.changeValueSlider(sender)
    }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        delegate?.changeSegmentedValue(sender)
    }
    
    public func changeTimeIntervalLabel(with value: Double) {
        labelTimeInterval.text = "\(Constants.changeAfterText) \(Int(value)) \(Constants.secondsText)"
    }
}
