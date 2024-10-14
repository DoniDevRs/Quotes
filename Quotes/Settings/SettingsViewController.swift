//
//  SettingsViewController.swift
//  QuotesApp
//
//  Created by Doni Silva on 26/08/24.
//

import UIKit

public class SettingsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let userConfig = UserConfiguration.shared
    private var settingsView: SettingsView?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
        setup()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    private func setup() {
        self.settingsView = SettingsView()
        self.view = settingsView
        settingsView?.delegate = self
    }
    
    private func formatView() {
        settingsView?.switchAutoRefresh.setOn(userConfig.autoRefresh, animated: false)
        settingsView?.sliderTimeInterval.setValue(Float(userConfig.timeInterval), animated: false)
        settingsView?.segmentedColorScheme.selectedSegmentIndex = userConfig.colorScheme
        settingsView?.changeTimeIntervalLabel(with: userConfig.timeInterval)
    }
}

extension SettingsViewController: SettingsViewDelegate {
    public func changeSwitch(_ sender: UISwitch) {
        userConfig.autoRefresh = sender.isOn
    }
    
    public func changeValueSlider(_ sender: UISlider) {
        let value = Double(round(sender.value))
        settingsView?.changeTimeIntervalLabel(with: value)
        userConfig.timeInterval = value
    }
    
    public func changeSegmentedValue(_ sender: UISegmentedControl) {
        userConfig.colorScheme = sender.selectedSegmentIndex
    }
}
