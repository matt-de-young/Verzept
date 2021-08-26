//
//  Note+CoreDataProperties.swift
//  Forking
//
//  Created by Matt de Young on 22.08.21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID
    @NSManaged public var created: Date
    @NSManaged public var text: String
    @NSManaged private var version: Version
    
    convenience init(
        context: NSManagedObjectContext!,
        text: String = ""
    ) {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.id = UUID()
        self.created = Date()
        self.text = text
    }
}

extension Note : Identifiable {

}
