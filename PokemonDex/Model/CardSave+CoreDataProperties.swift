//
//  CardSave+CoreDataProperties.swift
//  PokemonDex
//
//  Created by Nillia Sousa on 20/10/22.
//
//

import Foundation
import CoreData


extension CardSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardSave> {
        return NSFetchRequest<CardSave>(entityName: "CardSave")
    }

    @NSManaged public var url: String?

}

extension CardSave : Identifiable {

}
