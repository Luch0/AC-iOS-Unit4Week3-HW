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
    
    let favImagesPath = "favoriteImages.plist"
    
    var favPixabays = [Pixabay]() {
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
        let imageIndexFound = favPixabays.index{ $0.id == pixabay.id }
        if imageIndexFound != nil { return true }
        else { return false }
    }
    
    func saveImage(with pixabay: Pixabay, image: UIImage) {
        guard let imageData = UIImagePNGRepresentation(image) else { return }
        let imagePathName = FileManagerHelper.shared.dataFilePath(withPathName: "\(pixabay.id)")
        do {
            try imageData.write(to: imagePathName)
            favPixabays.append(pixabay)
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
            let encodedData = try propertyListEncoder.encode(favPixabays)
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
            let savedPixabays = try propertyListDecoder.decode([Pixabay].self, from: encodedData)
            favPixabays = savedPixabays
        }
        catch {
            print("Decoding error: " + error.localizedDescription)
        }
    }
    
    public func getFavoritePixabays() -> [Pixabay] {
        return favPixabays
    }

}
