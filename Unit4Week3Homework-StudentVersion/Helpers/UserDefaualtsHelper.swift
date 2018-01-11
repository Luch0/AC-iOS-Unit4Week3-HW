//
//  UserDefaualtsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    private init() { }
    static let shared = UserDefaultsHelper()
    
    let zipCodeKey = "zipCode"
    let locationNameKey = "location"
    
    func saveZipCode(zipCode: String) {
        UserDefaults.standard.setValue(zipCode, forKey: zipCodeKey)
    }
    
    func saveLocation(location: String) {
        UserDefaults.standard.setValue(location, forKey: locationNameKey)
    }
    
    func getSavedZipCode() -> String? {
        return UserDefaults.standard.object(forKey: zipCodeKey) as? String
    }
    
    func getSavedLocationName() -> String? {
        return UserDefaults.standard.object(forKey: locationNameKey) as? String
    }
    
}
