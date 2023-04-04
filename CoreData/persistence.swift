//
//  persistence.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 02/04/23.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController();
    
    // Container
//    let container : NSPersistentContainer;
    
    // Model
    let model : NSManagedObjectModel;
    
    init(inMemory : Bool = false) {
        
        //Entities
        
        let userEntity = NSEntityDescription();
        userEntity.name = "User"
        userEntity.managedObjectClassName = "User"
        
        let usernNameAttribute = NSAttributeDescription();
        usernNameAttribute.name = "userName"
        usernNameAttribute.type = .string
        
        let usernIdAttribute = NSAttributeDescription();
        usernIdAttribute.name = "id"
        usernIdAttribute.type = .uuid
        
        let UserFinancialTypeAttribute = NSAttributeDescription();
        UserFinancialTypeAttribute.name = "financialType"
        UserFinancialTypeAttribute.type = .string
        
        let userSalaryAttribute = NSAttributeDescription();
        userSalaryAttribute.name = "salary"
        userSalaryAttribute.type = .double
        
        userEntity.properties.append(usernIdAttribute)
        userEntity.properties.append(usernNameAttribute)
        userEntity.properties.append(UserFinancialTypeAttribute)
        userEntity.properties.append(userSalaryAttribute)
        
        let dateTransactionEntity = NSEntityDescription();
        dateTransactionEntity.name = "DateTransaction"
        dateTransactionEntity.managedObjectClassName = "DateTransaction"
        
        let dateIdAttribute = NSAttributeDescription();
        dateIdAttribute.name = "id"
        dateIdAttribute.type = .uuid
        
        let dateDateAttribute = NSAttributeDescription();
        dateDateAttribute.name = "dateTime"
        dateDateAttribute.type = .date
        
        let dateTotalTransaction = NSAttributeDescription();
        dateTotalTransaction.name = "TotalExpanditureDaily"
        dateTotalTransaction.type = .double
        
        dateTransactionEntity.properties.append(dateIdAttribute)
        dateTransactionEntity.properties.append(dateDateAttribute)
        
        // Relation
        
        let userRelation = NSRelationshipDescription()
        
        userRelation.name = "date"
        userRelation.destinationEntity = dateTransactionEntity
        userRelation.maxCount = 0
        userRelation.minCount = 0;
        
        let dateTransactionRelation = NSRelationshipDescription();
        
        dateTransactionRelation.name = "dateTransaction"
        dateTransactionRelation.destinationEntity = userEntity;
        dateTransactionRelation.maxCount = 1;
        dateTransactionRelation.minCount = 1;
        
        userEntity.properties.append(userRelation)
        dateTransactionEntity.properties.append(dateTransactionRelation)
        
        // ~Unused table just incase if change
//        let TransactionEntity = NSEntityDescription();
//        TransactionEntity.name = "transaction"
//        TransactionEntity.managedObjectClassName = "transaction"
//
//        let dayTransactionId = NSAttributeDescription()
//        TransactionId.name = "id"
//        TransactionId.type = .uuid
//
//        let daytransactionTotal = NSAttributeDescription();
        
        // Model Creation
        
        model = NSManagedObjectModel()
        model.entities.append(userEntity)
        model.entities.append(dateTransactionEntity)
        
        

        
    }
}
