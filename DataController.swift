//
//  DataController.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 03/04/23.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    
    let persistenceInstanceModel : NSManagedObjectModel = PersistenceController.shared.model
    
    let container : NSPersistentContainer
    
    init() {
        
        
        container = NSPersistentContainer(name: "CoreDataModel", managedObjectModel: persistenceInstanceModel)
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Core Data Failed to load, Error : \(error.localizedDescription)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
