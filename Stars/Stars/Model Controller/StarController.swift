//
//  StarController.swift
//  Stars
//
//  Created by Nelson Gonzalez on 4/30/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class StarController {
    
    init() {
        loadFromPersistentStore()
    }
    
    
  //Sun, Alpha Centauri, etc. ...
    //Only this class can set this attribute (Encapsulation: protect our data from (external) modification
    private(set) var stars: [Star] = []
    
    private var persitentURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("stars.plist")
    }
    
    //name and distance is what i need to know.
    func addStar(named name: String, withDistance distance: Double) {
        
        //1. create a star
        
        let newStar = Star(name: name, distance: distance)
        //2. Add star to the list
        
        stars.append(newStar)
        
        saveToPersistentStore()
    }
    
    //Save to disk
    func saveToPersistentStore() {
      //valid path
        guard let url = persitentURL else { return }
        //save to that path
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
            print("Error saving stars: \(error)")
        }
        
    }
    //Load from the disk
    func loadFromPersistentStore() {
        
       //Make sure file exists
        let fileManager = FileManager.default
        guard let url = persitentURL, fileManager.fileExists(atPath: url.path) else { return }
        
        
        //load and decode
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            stars = try decoder.decode([Star].self, from: data)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
}
