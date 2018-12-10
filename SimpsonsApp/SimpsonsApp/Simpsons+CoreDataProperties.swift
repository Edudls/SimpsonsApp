//
//  Simpsons+CoreDataProperties.swift
//  SimpsonsApp
//
//  Created by C02GC0VZDRJL on 12/10/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation
import CoreData


extension Simpsons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Simpsons> {
        return NSFetchRequest<Simpsons>(entityName: "Simpsons");
    }

    @NSManaged public var desc: String?
    @NSManaged public var image: NSData?
    @NSManaged public var name: String?

}
