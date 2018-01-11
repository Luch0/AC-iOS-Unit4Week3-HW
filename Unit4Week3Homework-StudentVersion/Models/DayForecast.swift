//
//  DayForecast.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct ForecastResponse: Codable {
    let response: [ResponseWrapper]
}

struct ResponseWrapper: Codable {
    let periods: [DayForecast]
}

struct DayForecast: Codable {
    let timestamp: Int
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let snowIN: Double
    let sunriseISO: String
    let sunsetISO: String
    let weather: String
    let weatherPrimary: String
    let icon: String
    let sunrise: Int
    let sunset: Int
    let windSpeedMPH: Int
}

struct ForecastAPIClient {
    
    private init() {}
    static let manager = ForecastAPIClient()
    
    let apiKey = "n2NYx9NGL2Ljf52XDPGfB"
    let secretKey = "RXc2IWjDMS12awjpdWxZ40Rh0lhUDuBuauFzC3bM"
    let endpointUrlStr = "https://api.aerisapi.com/forecasts/"
    
    func getForecast(with zipCode: String, completionHandler: @escaping ([DayForecast]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "\(endpointUrlStr)\(zipCode)?client_id=\(apiKey)&client_secret=\(secretKey)"
        guard let url = URL(string: fullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
                if forecastResponse.response.isEmpty {
                    errorHandler(AppError.zipCodeError)
                    return
                }
                completionHandler(forecastResponse.response[0].periods)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
