//
//  FavoriteImagesViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteImagesViewController: UIViewController {

    let favoriteImagesView = FavoriteImagesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoriteImagesView)
        favoriteImagesView.favoritesTableView.delegate = self
        favoriteImagesView.favoritesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteImagesView.favoritesTableView.reloadData()
    }

}

extension FavoriteImagesViewController: UITableViewDataSource {
    
    // https://stackoverflow.com/questions/28532926/if-no-table-view-results-display-no-results-on-screen
    // reference for label when no favorite images in tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if FileManagerHelper.shared.getFavoritePixabays().count > 0 {
            favoriteImagesView.favoritesTableView.backgroundView = nil
            favoriteImagesView.favoritesTableView.separatorStyle = .singleLine
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: favoriteImagesView.favoritesTableView.bounds.size.width, height: favoriteImagesView.favoritesTableView.bounds.size.height))
            noDataLabel.text = "No Favorites Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            noDataLabel.textAlignment = .center
            favoriteImagesView.favoritesTableView.backgroundView = noDataLabel
            favoriteImagesView.favoritesTableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FileManagerHelper.shared.getFavoritePixabays().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favCell =  tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteImageTableViewCell
        let favPixabay = FileManagerHelper.shared.getFavoritePixabays().reversed()[indexPath.row]
        favCell.favoriteImageView.image = FileManagerHelper.shared.getImage(with: favPixabay)
        // TODO: make sure right location name displays
        favCell.locationNameLabel.text = UserDefaultsHelper.shared.getSavedLocationName()
        return favCell
    }
    
}

extension FavoriteImagesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favCell = tableView.cellForRow(at: indexPath) as! FavoriteImageTableViewCell
        let animation = CABasicAnimation(keyPath: "opacity")
        let customTimingFunction = CAMediaTimingFunction(controlPoints: 0, 0.5, 0.5, 1)
        animation.timingFunction = customTimingFunction
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        favCell.locationNameLabel.layer.add(animation, forKey: nil)
    }
    
}
