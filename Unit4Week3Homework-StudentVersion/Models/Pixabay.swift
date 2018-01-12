//
//  Pixabay.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct PixabayResponse: Codable {
    let hits: [Pixabay]
}

struct Pixabay: Codable {
    let id: Int
    let webformatURL: String
}

struct PixabayAPIClient {
    
    private init() { }
    static let manager = PixabayAPIClient()
    
    let apiKey = "7290172-07f01a2f73666a4c5696bb2f4"
    let endpoint = "https://pixabay.com/api/?"
    
    func getRandomImage(from location: String, completionHandler: @escaping (Pixabay) -> Void, errorHandler: @escaping (Error) -> Void) {
        let fullUrl = "\(endpoint)key=\(apiKey)&q=\(location)"
        guard let encodedFullUrl = fullUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        guard let url = URL(string: encodedFullUrl) else {
            errorHandler(AppError.badURL(str: fullUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = { (data: Data) in
            do {
                let pixabayResponse = try JSONDecoder().decode(PixabayResponse.self, from: data)
                if pixabayResponse.hits.isEmpty {
                    errorHandler(AppError.noImages)
                    return
                }
                let randomIndex = Int(arc4random_uniform(UInt32(pixabayResponse.hits.count - 1)))
                let randomPixabay = pixabayResponse.hits[randomIndex]
                completionHandler(randomPixabay)
            }
            catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
