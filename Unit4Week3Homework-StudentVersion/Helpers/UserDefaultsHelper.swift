//
//  UserDefaualtsHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case zipCode
    case location
    case metricSystem
    case segmentedControlIndex
}

class UserDefaultsHelper {
    
    private init() { }
    static let shared = UserDefaultsHelper()
    
    func saveZipCode(zipCode: String) {
        UserDefaults.standard.setValue(zipCode, forKey: UserDefaultsKeys.zipCode.rawValue)
    }
    
    func saveLocation(location: String) {
        UserDefaults.standard.setValue(location, forKey: UserDefaultsKeys.location.rawValue)
    }
    
    func saveMetricSetting(system: String) {
        UserDefaults.standard.setValue(system, forKey: UserDefaultsKeys.metricSystem.rawValue)
    }
    
    func saveSegmentedControlIndex(index: Int) {
        UserDefaults.standard.set(index, forKey: UserDefaultsKeys.segmentedControlIndex.rawValue)
    }
    
    func getSavedZipCode() -> String? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.zipCode.rawValue) as? String
    }
    
    func getSavedLocationName() -> String? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.location.rawValue) as? String
    }
    
    func getMetricSystem() -> String? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.metricSystem.rawValue) as? String
    }
    
    func getSegmentedControlIndex() -> Int? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.segmentedControlIndex.rawValue) as? Int
    }
    
}
