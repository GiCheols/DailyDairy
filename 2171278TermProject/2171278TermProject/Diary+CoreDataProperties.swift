//
//  Diary+CoreDataProperties.swift
//  
//
//  Created by 남기철 on 2024/06/07.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var date: Date?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: Data?

}
