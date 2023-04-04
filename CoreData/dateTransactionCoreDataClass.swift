//
//  File.swift
//  
//
//  Created by Elvin Sestomi on 03/04/23.
//

import Foundation
import CoreData

@objc(DateTransaction)
public class DateTransaction : NSManagedObject {
    @NSManaged public var id : UUID?
    @NSManaged public var dateTime : Date?
    @NSManaged public var TotalExpanditureDaily : Double
    @NSManaged public var user : User?
}

extension  DateTransaction : Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateTransaction> {
        return NSFetchRequest<DateTransaction>(entityName: "DateTransaction")
    }
}
