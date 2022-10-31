//
//  Persistencia.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 24/10/22.
//

import UIKit

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainers: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PokemonDex")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        
        return container
    }()
    
    func createSaveCard(id: String, url: String) {
        let context = persistentContainers.viewContext
        
        let CardSaved = CardSalvo(context: context)
        
        CardSaved.id = id
        CardSaved.url = url
        
        do {
            try context.save()
        } catch let error {
            print("Failed to creat: \(error)")
        }
        
    }
    
    func fetchSaveCards() -> [CardSalvo]? {
        let context = persistentContainers.viewContext
        
        let fetchRequest = NSFetchRequest<CardSalvo>(entityName: "CardSalvo")
        
        do {
            let cardSaveds = try context.fetch(fetchRequest)
            return cardSaveds
        } catch let error {
            print("Failed to fetch companies: \(error)" )
        }
        return nil
    }
    
    func fetchSaveCard(with id: String, url: String) -> CardSalvo? {
        let context = persistentContainers.viewContext
        
        let fetchRequest = NSFetchRequest<CardSalvo>(entityName: "CardSalvo")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name ==%$", id)
        
        do {
            let SaveCards = try context.fetch(fetchRequest)
            return SaveCards.first
        } catch let error {
            print("Failed to fecth: \(error)")
        }
        return nil
    }
    
}




