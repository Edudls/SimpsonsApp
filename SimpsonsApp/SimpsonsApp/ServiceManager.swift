//
//  ServiceManager.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/7/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation
/*
class ServiceManager {
    
    let apiURL = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")!
    
    func downloadSimpsons(/*completion: @escaping ([Simpsons])->()*/) -> [Simpsons] {
        
        var simpsons = [Simpsons]()
        // create a connection to the server
        // get data from the server
        let dataTask = URLSession.shared.dataTask(with: apiURL) { [unowned self]
            (data, response, error) in
            // completion handler, does work when done
            guard let safeData = data else { return }
            
            // JSONSerialization for the data
            do {
                let json = try JSONSerialization.jsonObject(with: safeData, options: .mutableLeaves) as! [String:Any]
                
                //print(json)
                // parse, create objects
                // this API is set up as an array of dictionaries containing further dictionaries...
                let characters = json["RelatedTopics"] as! [[String:Any]]
                
                //print(characters[0]) //prints dictionary containing Apu's info since list is alphabetical by first name
                
                
                
                for character in characters {
                    let img = character["Icon"] as! [String:String]
                    let text = character["Text"] as! String
                    //split text up into name and desc, respectively
                    let separated = text.components(separatedBy: " - ")
                    //print(separated)
                    //print(img["URL"]!)
                    
                    //let imgData = self.downloadSimpsonImage(img["URL"]!)
                    
                    /*self.downloadSimpsonImage(img["URL"]!, completion: { (imageData) in
                        //send back to collectionView to show
                        DispatchQueue.main.async {
                            
                            let newSimpson = PersistenceManager.addSimpson(separated[0], separated[1], imageData)
                            print(newSimpson)
                            simpsons.append(newSimpson)
                        }
                     })*/
                    
                }
                /*
                guard let charImageString = self.getImageURL(json) else {
                    return
                }
                
                
                self.downloadImage(charImageString, completion: { (imageData) in
                    //send back to collectionView to show
                    DispatchQueue.main.async {
                        
                        //let newSimpson = PersistenceManager.addSimpson(charDesc, imageData)
                        //completion(newSimpson)
                    }
                })*/
                
            }
            catch { }
            
        }
        dataTask.resume()
        
    }
    
    /*
    func getImageURL(_ json: [String:Any]) -> String? {
        guard let sprites = json["sprites"] as? [String:Any] else {
            return nil
        }
        let frontShiny = sprites["front_shiny"] as? String
        return frontShiny
    }*/
    /*
    func downloadImage(_ urlString: String,
                              completion: @escaping (Data)->()) {
        
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let safeData = data {
                print("Did receive image data")
                completion(safeData)
            }
        }
        
        dataTask.resume()
        
    }*/
    
}*/

