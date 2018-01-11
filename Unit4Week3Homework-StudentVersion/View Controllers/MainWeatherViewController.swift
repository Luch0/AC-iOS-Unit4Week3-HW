//
//  MainWeatherViewController.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/5/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainWeatherViewController: UIViewController {

    let mainWeatherView = MainWeatherView()
    
    let cellSpacing: CGFloat = 5.0
    
    var forecast = [DayForecast]() {
        didSet {
            mainWeatherView.forecastCollectionView.reloadData()
            mainWeatherView.forecastCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainWeatherView.backgroundColor = UIColor.groupTableViewBackground
        mainWeatherView.forecastCollectionView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(mainWeatherView)
        navigationItem.title = "Search"
        
        mainWeatherView.forecastCollectionView.delegate = self
        mainWeatherView.forecastCollectionView.dataSource = self
        mainWeatherView.zipCodeTextField.delegate = self
        
        loadLastLocation()
    }
    
    func loadLastLocation() {
        guard let zipCode = UserDefaultsHelper.shared.getSavedZipCode() else { return }
        mainWeatherView.zipCodeTextField.text = zipCode
        ForecastAPIClient.manager.getForecast(with: zipCode, completionHandler: {
            self.forecast = $0
            ZipCodeHelper.manager.getLocationName(from: zipCode, completionHandler: {
                self.location = $0
                self.mainWeatherView.locationForecastLabel.text = "Weather Forecast for \($0)"
            }, errorHandler: {
                self.mainWeatherView.locationForecastLabel.text = "Place not found for \(zipCode)"
                self.forecast = []
                print($0)
            })
        }, errorHandler: {
            self.mainWeatherView.locationForecastLabel.text = "Weather Forecast"
            self.showAlertController(with: "Error", message: "Forecast not available for \(zipCode)")
            self.forecast = []
            print($0)
        })
    }

}

extension MainWeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainWeatherView.messageLabel.text = "Enter a Zip Code"
        guard let textFieldText = textField.text else { return false }
        ForecastAPIClient.manager.getForecast(with: textFieldText, completionHandler: {
            self.forecast = $0
            UserDefaultsHelper.shared.saveZipCode(zipCode: textFieldText)
            ZipCodeHelper.manager.getLocationName(from: textFieldText, completionHandler: {
                self.location = $0
                self.mainWeatherView.locationForecastLabel.text = "Weather Forecast for \($0)"
                UserDefaultsHelper.shared.saveLocation(location: $0)
            }, errorHandler: {
                self.mainWeatherView.locationForecastLabel.text = "Place not found for \(textFieldText)"
                self.forecast = []
                print($0)
            })
        }, errorHandler: {
            self.mainWeatherView.locationForecastLabel.text = "Weather Forecast"
            self.forecast = []
            self.showAlertController(with: "Error", message: "Forecast not available for \(textFieldText)")
            print($0)
        })
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MainWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! ForecastCollectionViewCell
        cell.backgroundColor = .white
        let dayForecast = forecast[indexPath.row]
        cell.dateLabel.text = Date(timeIntervalSince1970: Double(dayForecast.timestamp)).description.components(separatedBy: " ")[0]
        cell.forecastImageView.image = nil
        cell.forecastImageView.image = UIImage(named: dayForecast.icon)
        cell.highTempLabel.text = "High: \(dayForecast.maxTempF) ℉"
        cell.lowTempLabel.text = "Low: \(dayForecast.minTempF) ℉"
        
        animateCellShadow(cell: cell)
        
        return cell
    }
    
    func animateCellShadow(cell: ForecastCollectionViewCell) {
        let cellOpacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        cellOpacityAnimation.fromValue = 0
        cellOpacityAnimation.toValue = 1
        cell.layer.shadowOpacity = 1
        let cellOffsetAnimation = CABasicAnimation(keyPath: "shadowOffset")
        cellOffsetAnimation.fromValue = CGSize.zero
        cellOffsetAnimation.toValue = CGSize(width: 3.0, height: 3.0)
        cell.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1.0
        groupAnimation.animations = [cellOpacityAnimation, cellOffsetAnimation]
        cell.layer.add(groupAnimation, forKey: nil)
    }
    
}

extension MainWeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let forecastCell = collectionView.cellForItem(at: indexPath) as! ForecastCollectionViewCell
        let dayForecast = forecast[indexPath.row]
        let weatherDetailViewController = WeatherDetailViewController(dayForecast: dayForecast, date: forecastCell.dateLabel.text!, location: location!)
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
    
}

extension MainWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3.1
        let numSpaces: CGFloat = numCells + 1
        
        let collectionViewWidth = mainWeatherView.forecastCollectionView.bounds.width
        let collectionViewHeight = mainWeatherView.forecastCollectionView.bounds.height
        
        return CGSize(width: (collectionViewWidth - (cellSpacing * numSpaces)) / numCells, height: collectionViewHeight * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}
