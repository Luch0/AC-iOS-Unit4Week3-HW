//
//  WeatherDetailView.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {
    
    var pixabay: Pixabay?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Main Label"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var locationImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "locationImagePlaceholder")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 3.0
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        return imageView
    }()
    
    lazy var heartImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "heart")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.opacity = 0
        return imageView
    }()
    
    lazy var forecastLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Forecast label"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "High temp Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Low temp Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sunrise Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sunset Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var windspeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Windspeed Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var precipitationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Precipitation Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        setupMainLabel()
        setupLocationImageView()
        setupHeartImageView()
        setupForecastLabel()
        setupHighTempLabel()
        setupLowTempLabel()
        setupSunriseLabel()
        setupSunsetLabel()
        setupWindspeedLabel()
        setupPrecipitationLabel()
    }
    
    private func setupMainLabel() {
        addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            mainLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            mainLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func setupLocationImageView() {
        addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 16),
            locationImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            locationImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            locationImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupHeartImageView() {
        addSubview(heartImageView)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heartImageView.centerXAnchor.constraint(equalTo: locationImageView.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            heartImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            heartImageView.heightAnchor.constraint(equalTo: heartImageView.widthAnchor)
        ])
    }
    
    private func setupForecastLabel() {
        addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            forecastLabel.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 8),
            forecastLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupHighTempLabel() {
        addSubview(highTempLabel)
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highTempLabel.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: 16),
            highTempLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupLowTempLabel() {
        addSubview(lowTempLabel)
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowTempLabel.topAnchor.constraint(equalTo: highTempLabel.bottomAnchor, constant: 8),
            lowTempLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupSunriseLabel() {
        addSubview(sunriseLabel)
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunriseLabel.topAnchor.constraint(equalTo: lowTempLabel.bottomAnchor, constant: 8),
            sunriseLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupSunsetLabel() {
        addSubview(sunsetLabel)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 8),
            sunsetLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupWindspeedLabel() {
        addSubview(windspeedLabel)
        windspeedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            windspeedLabel.topAnchor.constraint(equalTo: sunsetLabel.bottomAnchor, constant: 8),
            windspeedLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupPrecipitationLabel() {
        addSubview(precipitationLabel)
        precipitationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            precipitationLabel.topAnchor.constraint(equalTo: windspeedLabel.bottomAnchor, constant: 8),
            precipitationLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            precipitationLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func configureDetailView(dayForecast: DayForecast, date: String, location: String) {
        self.mainLabel.text = "Weather Forecast for \(location) for \(date)"
        self.forecastLabel.text = dayForecast.weatherPrimary

        configureDetails(dayForecast: dayForecast)

        PixabayAPIClient.manager.getRandomImage(from: location, completionHandler: {
            let pixabayToSet: Pixabay = $0
            ImageFetchHelper.manager.getImage(with: $0, completionHandler: {
                self.locationImageView.image = $0
                self.pixabay = pixabayToSet
                self.locationImageView.setNeedsLayout()
            }, errorHandler: { print($0) })
        }, errorHandler: { print($0) })
    }
    
    func configureDetails(dayForecast: DayForecast) {
        if UserDefaultsHelper.shared.getMetricSystem() == "Metric" {
            configureWithMetric(dayForecast: dayForecast)
        } else {
            configureWithImperial(dayForecast: dayForecast)
        }
    }
    
    // https://stackoverflow.com/questions/24777496/how-can-i-convert-string-date-to-nsdate
    // reference for changing 24-hour to AM/PM
    private func configureWithImperial(dayForecast: DayForecast) {
        self.highTempLabel.text = "High: \(dayForecast.maxTempF) ℉"
        self.lowTempLabel.text = "Low: \(dayForecast.minTempF) ℉"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        self.sunriseLabel.text = "Sunrise: \(dateFormatter.string(from: Date(timeIntervalSince1970: Double(dayForecast.sunrise))))"
        self.sunsetLabel.text = "Sunset: \(dateFormatter.string(from: Date(timeIntervalSince1970: Double(dayForecast.sunset))))"
        self.windspeedLabel.text = "Windspeed: \(dayForecast.windSpeedMPH) MPH"
        self.precipitationLabel.text = "Inches of Precipitation: \(dayForecast.precipIN) IN"
    }
    
    private func configureWithMetric(dayForecast: DayForecast) {
        self.highTempLabel.text = "High: \(dayForecast.maxTempC) ℃"
        self.lowTempLabel.text = "Low: \(dayForecast.minTempC) ℃"
        self.sunriseLabel.text = "Sunrise: \(Date(timeIntervalSince1970: Double(dayForecast.sunrise)).description.components(separatedBy: " ")[1])"
        self.sunsetLabel.text = "Sunset: \(Date(timeIntervalSince1970: Double(dayForecast.sunset)).description.components(separatedBy: " ")[1])"
        self.windspeedLabel.text = "Windspeed: \(dayForecast.windSpeedKPH) KPH"
        self.precipitationLabel.text = "Inches of Precipitation: \(dayForecast.precipMM) MM"
    }

}
