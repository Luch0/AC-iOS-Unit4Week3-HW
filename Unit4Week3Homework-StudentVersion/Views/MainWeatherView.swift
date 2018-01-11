//
//  MainWeatherView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherView: UIView {
    
    lazy var locationForecastLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather Forecast"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var forecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "forecastCell")
        return collectionView
    }()
    
    lazy var zipCodeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Zip Code"
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.borderStyle = UITextBorderStyle.roundedRect
        return textField
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter a Zip Code"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupLocationForecastLabel()
        setupForecastCollectionView()
        setupZipCodeTextField()
        setupMessageLabel()
    }
    
    private func setupLocationForecastLabel() {
        addSubview(locationForecastLabel)
        locationForecastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationForecastLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            locationForecastLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            locationForecastLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupForecastCollectionView() {
        addSubview(forecastCollectionView)
        forecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forecastCollectionView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.35),
            forecastCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            forecastCollectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            forecastCollectionView.topAnchor.constraint(equalTo: locationForecastLabel.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupZipCodeTextField() {
        addSubview(zipCodeTextField)
        zipCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zipCodeTextField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            zipCodeTextField.topAnchor.constraint(equalTo: forecastCollectionView.bottomAnchor, constant: 16),
            zipCodeTextField.centerXAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    
    private func setupMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: zipCodeTextField.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
}
