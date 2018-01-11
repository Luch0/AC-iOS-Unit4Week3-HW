//
//  FavoriteImagesView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteImagesView: UIView {
    
    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteImageTableViewCell.self, forCellReuseIdentifier: "FavoriteCell")
        return tableView
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
        setupFavoritesTableview()
    }
    
    private func setupFavoritesTableview() {
        addSubview(favoritesTableView)
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

}
