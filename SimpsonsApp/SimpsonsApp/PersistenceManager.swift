//
//  PersistenceManager.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/8/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static let sharedInstance = PersistenceManager()
    private init() { }
    
    private lazy var mainContext = {
        return PersistenceManager.sharedInstance.persistentContainer.viewContext
    }()
    
    static func addSimpson(_ name: String,
                              _ desc: String,
                              _ imageData: Data) -> Simpsons {
        
        /* make moves (left in for reference)
        var pokeMoves: [Move] = [Move]()
        pokeMoves.reserveCapacity(moves.count)
        let description = NSEntityDescription.entity(forEntityName: "Move",
                                                     in: PersistenceManager.sharedInstance.mainContext)
        for move in moves {
            let myNewMove = Move(entity: description!,
                                 insertInto: PersistenceManager.sharedInstance.mainContext)
            myNewMove.name = move
            pokeMoves.append(myNewMove)
        }*/
        
        // add a character
        let newSimpson = NSEntityDescription.insertNewObject(forEntityName: "Simpsons",
                                                               into: PersistenceManager.sharedInstance.mainContext)
        newSimpson.setValue(name, forKey: "name")
        newSimpson.setValue(desc, forKey: "desc")
        newSimpson.setValue(imageData, forKey: "image")
        
        // save the context
        PersistenceManager.sharedInstance.saveContext()
        
        return newSimpson as! Simpsons
    }
    
    /*static func addSimpsons(_ simpsonsDicts: [[String: Any]]) {
        
    }*/
    
    /*static func addPokemonToTrainer(_ pokemon: Pokemon) {
        pokemon.trainer = PersistenceManager.sharedInstance.trainer
        
        PersistenceManager.sharedInstance.saveContext()
    }*/
    
    static func loadSavedSimpson() -> [Simpsons] {
 
         let fetchRequest = NSFetchRequest<Simpsons>(entityName: "Simpson")
 
         do {
         let savedSimpsons = try PersistenceManager.sharedInstance.mainContext.fetch(fetchRequest)
         return savedSimpsons
         }
         catch {
         return []
         }
 
    }
    /*
    static func deleteAllPokemon(_ name: String) {
        let context = PersistenceManager.sharedInstance.mainContext
        let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
        
        // refine our fetch request
        let hitmontopPredicate = NSPredicate(format: "name = %@",
                                             argumentArray: [name])
        fetchRequest.predicate = hitmontopPredicate
        do {
            let savedPokemon = try context.fetch(fetchRequest)
            for pokemon in savedPokemon {
                context.delete(pokemon)
            }
            PersistenceManager.sharedInstance.saveContext()
        }
        catch { }
    }*/
    
    static func saveSimpsons() {
        PersistenceManager.sharedInstance.saveContext()
    }
    
    static func deleteSimpson(_ simpson: Simpsons) {
        let context = PersistenceManager.sharedInstance.mainContext
        context.delete(simpson)
        PersistenceManager.sharedInstance.saveContext()
    }
    /*
    static func queryForPokemon() {
        let context = PersistenceManager.sharedInstance.mainContext
        
        let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
        do {
            let savedPokemon = try context.fetch(fetchRequest)
            print("savedPokemon: \(savedPokemon.count)")
        } catch { }
        
    }
    
    static func deleteAllWildPokemon() {
        let context = PersistenceManager.sharedInstance.mainContext
        
        let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
        let predicate = NSPredicate(format: "trainer = nil")
        fetchRequest.predicate = predicate
        do {
            let savedPokemon = try context.fetch(fetchRequest)
            savedPokemon.forEach { mon in
                context.delete(mon)
            }
        } catch { }
        
        PersistenceManager.sharedInstance.saveContext()
    }*/
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SimpsonsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    private func saveContext () {
        let context = mainContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
