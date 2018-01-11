//
//  ImageFetchHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

struct ImageFetchHelper {
    
    private init() {}
    static let manager = ImageFetchHelper()
    
    func getImage(with pixabay: Pixabay, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: pixabay.webformatURL) else { errorHandler(AppError.badURL(str: pixabay.webformatURL)); return }
        let request = URLRequest(url: url)
        if let cachedImage = NSCacheHelper.manager.getImage(with: pixabay.id.description) {
            print("Getting cached image")
            completionHandler(cachedImage)
            return
        }
        let completion: (Data) -> Void = { (data: Data) in
            guard let onlineImage = UIImage(data: data) else { errorHandler(AppError.notAnImage); return }
            NSCacheHelper.manager.addImage(with: pixabay.id.description, and: onlineImage)
            print("Getting image from web")
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: errorHandler)
    }
    
}
