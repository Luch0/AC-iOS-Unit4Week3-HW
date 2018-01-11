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
        view.addSubview(weatherDetailView)
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Forecast"
        let saveImageBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImage))
        navigationItem.rightBarButtonItem = saveImageBarButton
    }
    
    @objc func saveImage() {
        guard let pixabay = weatherDetailView.pixabay, let image = weatherDetailView.locationImageView.image  else {
            showAlertController(with: "Error", message: "No image to save")
            return
        }
        if FileManagerHelper.shared.isImageAlreadySaved(pixabay: pixabay) {
            showAlertController(with: "Could not Save", message: "Image already in favorites")
            return
        }
        FileManagerHelper.shared.saveImage(with: pixabay , image: image)
    }
    
    func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
