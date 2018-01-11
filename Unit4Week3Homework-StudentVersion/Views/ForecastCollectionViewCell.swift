//
//  ForecastCollectionViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "Date here"
        label.textAlignment = .center
        return label
    }()
    
    lazy var forecastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "forecastImagePlaceholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var highTempLabel: UILabel = {
        var label = UILabel()
        label.text = "High here"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        var label = UILabel()
        label.text = "Low Here"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        setupDateLabel()
        setupForecastImageView()
        setupHighTempLabel()
        setupLowTempLabel()
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func setupForecastImageView() {
        addSubview(forecastImageView)
        forecastImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forecastImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            forecastImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            forecastImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            forecastImageView.heightAnchor.constraint(equalTo: forecastImageView.widthAnchor)
        ])
    }
    
    private func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTempLabel.topAnchor.constraint(equalTo: forecastImageView.bottomAnchor, constant: 4),
            highTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            highTempLabel.widthAnchor.constraint(equalTo: widthAnchor),
            highTempLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor)
        ])
    }
    
    private func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor),
            lowTempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            lowTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            lowTempLabel.widthAnchor.constraint(equalTo: widthAnchor),
            lowTempLabel.heightAnchor.constraint(equalTo: highTempLabel.heightAnchor)
        ])
    }
    
}
