//
//  File.swift
//  
//
//  Created by Elvin Sestomi on 03/04/23.
//
import CoreData
import Foundation


@objc(User)
public class User : NSManagedObject {
    @NSManaged public var id : UUID?
    @NSManaged public var userName : String?
    @NSManaged public var financialType : String?
    @NSManaged public var salary : String?
    @NSManaged public var date : NSSet?
    
}

extension User{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    public var transactionArray : [DateTransaction] {
        let set = date as? Set<DateTransaction> ?? [];
        
        return set.sorted {
            $0.dateTime! < $1.dateTime!
        }
    }
}
