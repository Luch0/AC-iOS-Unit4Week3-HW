//
//  FileMangerHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by Luis Calle on 1/9/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FileManagerHelper {
    
    private init() { }
    static let shared = FileManagerHelper()
    
    let favImagesPath = "favoritePixabays.plist"
    
    var favPixabaysArray = [FavoritePixabay]() {
        didSet {
            savePixabays()
        }
    }
    
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.shared.documentsDirectory().appendingPathComponent(path)
    }
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    public func isImageAlreadySaved(pixabay: Pixabay) -> Bool {
        let imageIndexFound = favPixabaysArray.index{ $0.pixabay.id == pixabay.id }
        if imageIndexFound != nil { return true }
        else { return false }
    }
    
    func saveImage(with favPixabay: FavoritePixabay, image: UIImage) {
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        let imagePathName = FileManagerHelper.shared.dataFilePath(withPathName: "\(favPixabay.pixabay.id)")
        do {
            try imageData.write(to: imagePathName)
            favPixabaysArray.append(favPixabay)
        } catch {
            print("Image saving error: \(error.localizedDescription)")
        }
    }
    
    func getImage(with pixabay: Pixabay) -> UIImage? {
        do {
            let imagePathName = FileManagerHelper.shared.dataFilePath(withPathName: "\(pixabay.id)")
            let data = try Data(contentsOf: imagePathName)
            return UIImage(data: data)
        }
        catch {
            print("Error getting image: " + error.localizedDescription)
            return nil
        }
    }
    
    private func savePixabays() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(favPixabaysArray)
            let phoneURL = dataFilePath(withPathName: favImagesPath)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print("Encoding error: " + error.localizedDescription)
        }
    }
    
    func loadPixabays() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: favImagesPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedPixabays = try propertyListDecoder.decode([FavoritePixabay].self, from: encodedData)
            favPixabaysArray = savedPixabays
        }
        catch {
            print("Decoding error: " + error.localizedDescription)
        }
    }
    
    public func getFavoritePixabays() -> [FavoritePixabay] {
        return favPixabaysArray
    }

}
