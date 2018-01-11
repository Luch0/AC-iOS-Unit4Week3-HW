//
//  NSCacheHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class NSCacheHelper {
    
    private init() { }
    static let manager = NSCacheHelper()
    
    private var myCache = NSCache<NSString, UIImage>()
    
    func addImage(with id: String, and image: UIImage) {
        myCache.setObject(image, forKey: id as NSString)
    }
    
    func getImage(with id: String) -> UIImage? {
        return myCache.object(forKey: id as NSString)
    }
    
}
