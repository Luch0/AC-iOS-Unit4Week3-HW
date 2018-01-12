//
//  WeatherDetailViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    let weatherDetailView = WeatherDetailView()
    
    private var dayForecast: DayForecast!
    
    init(dayForecast: DayForecast, date: String, location: String) {
        super.init(nibName: nil, bundle: nil)
        self.dayForecast = dayForecast
        weatherDetailView.configureDetailView(dayForecast: dayForecast, date: date, location: location)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherDetailView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(weatherDetailView)
        configureNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherDetailView.configureDetails(dayForecast: dayForecast)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Forecast"
        let saveImageBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
        navigationItem.rightBarButtonItem = saveImageBarButton
    }
    
    @objc private func saveImage() {
        guard let pixabay = weatherDetailView.pixabay, let image = weatherDetailView.locationImageView.image  else {
            showAlertController(with: "Error", message: "No image to save")
            return
        }
        if FileManagerHelper.shared.isImageAlreadySaved(pixabay: pixabay) {
            showAlertController(with: "Could not save", message: "Image already in favorites")
            return
        }
        if let locationName = UserDefaultsHelper.shared.getSavedLocationName() {
            let favPixabayToSave = FavoritePixabay(pixabay: pixabay, locationName: locationName)
            FileManagerHelper.shared.saveImage(with: favPixabayToSave , image: image)
            favoritedAnimation()
        }
    }
    
    private func favoritedAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.4
        weatherDetailView.heartImageView.layer.add(animation, forKey: nil)
    }
    
    private func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
