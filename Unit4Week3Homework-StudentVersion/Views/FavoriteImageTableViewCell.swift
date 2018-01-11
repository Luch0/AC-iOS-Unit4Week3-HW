//
//  FavoriteImageTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteImageTableViewCell: UITableViewCell {

    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var locationNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Location Name"
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 3
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.layer.opacity = 0.0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FavoriteCell")
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
        setupFavoriteImageView()
        setupLocatioNameLabel()
    }
    
    private func setupFavoriteImageView() {
        addSubview(favoriteImageView)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoriteImageView.topAnchor.constraint(equalTo: topAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            favoriteImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupLocatioNameLabel() {
        addSubview(locationNameLabel)
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
