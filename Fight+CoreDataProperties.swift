//
//  Fight+CoreDataProperties.swift
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

extension Fight {

    @NSManaged var contestantOne: String?
    @NSManaged var contestantTwo: String?
    @NSManaged var tournament: Tournament?

}
