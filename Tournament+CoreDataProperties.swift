//
//  Tournament+CoreDataProperties.swift
//  Tournament
//
//  Created by Raichu on 1/19/16.
//  Copyright © 2016 Richard. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tournament {

    @NSManaged var date: String?
    @NSManaged var name: String?
    @NSManaged var type: String?
    @NSManaged var fights: NSSet?
    @NSManaged var contestants: NSSet?

}
