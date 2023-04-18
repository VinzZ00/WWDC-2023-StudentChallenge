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
    @NSManaged public var dateTransaction : User?
    @NSManaged public var detail : String?
    @NSManaged public var transactionPrice : String?
    @NSManaged public var dateTime : Date?
    @NSManaged public var descriptionTransaction : String?
}

extension  DateTransaction {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateTransaction> {
        return NSFetchRequest<DateTransaction>(entityName: "DateTransaction")
    }
}
