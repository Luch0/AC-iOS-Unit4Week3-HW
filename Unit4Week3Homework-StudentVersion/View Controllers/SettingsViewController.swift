//
//  SettingsViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var conversionLabel: UILabel = {
        let label = UILabel()
        label.text = "Conversion"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    lazy var settingSegmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: ["Imperial","Metric"])
        if let segmentIndex = UserDefaultsHelper.shared.getSegmentedControlIndex() {
            segmentedControl.selectedSegmentIndex = segmentIndex
        } else {
            segmentedControl.selectedSegmentIndex = 0
        }
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        settingSegmentedControl.addTarget(self, action: #selector(segmentedControlPressed), for: .valueChanged)
        setupConversionLabel()
        setupSettingSegmentedControl()
    }
    
    @objc private func segmentedControlPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            guard let chosenMetric = sender.titleForSegment(at: 0) else { return }
            UserDefaultsHelper.shared.saveMetricSetting(system: chosenMetric)
            UserDefaultsHelper.shared.saveSegmentedControlIndex(index: 0)
        case 1:
            guard let chosenMetric = sender.titleForSegment(at: 1) else { return }
            UserDefaultsHelper.shared.saveMetricSetting(system: chosenMetric)
            UserDefaultsHelper.shared.saveSegmentedControlIndex(index: 1)
        default:
            print("No segmented control selected")
        }
    }
    
    private func setupConversionLabel() {
        view.addSubview(conversionLabel)
        conversionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conversionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            conversionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func setupSettingSegmentedControl() {
        view.addSubview(settingSegmentedControl)
        settingSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingSegmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            settingSegmentedControl.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            settingSegmentedControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6)
        ])
    }

}
