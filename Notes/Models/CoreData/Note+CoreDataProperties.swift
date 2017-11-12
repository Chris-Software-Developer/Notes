//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Christopher Smith on 11/12/17.
//  Copyright © 2017 Christopher Smith. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var details: String?

}
