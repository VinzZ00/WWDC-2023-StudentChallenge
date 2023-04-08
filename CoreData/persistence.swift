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
        
        let userNameAttribute = NSAttributeDescription();
        userNameAttribute.name = "userName"
        userNameAttribute.type = .string
        
        let userIdAttribute = NSAttributeDescription();
        userIdAttribute.name = "id"
        userIdAttribute.type = .uuid
        
        let UserFinancialTypeAttribute = NSAttributeDescription();
        UserFinancialTypeAttribute.name = "financialType"
        UserFinancialTypeAttribute.type = .string
        
        let userSalaryAttribute = NSAttributeDescription();
        userSalaryAttribute.name = "salary"
        userSalaryAttribute.type = .string
        
        userEntity.properties.append(userIdAttribute)
        userEntity.properties.append(userNameAttribute)
        userEntity.properties.append(UserFinancialTypeAttribute)
        userEntity.properties.append(userSalaryAttribute)
        
        let dateTransactionEntity = NSEntityDescription();
        dateTransactionEntity.name = "DateTransaction"
        dateTransactionEntity.managedObjectClassName = "DateTransaction"
        
        let dateIdAttribute = NSAttributeDescription();
        dateIdAttribute.name = "id"
        dateIdAttribute.type = .uuid
        
        let transactionDetail = NSAttributeDescription()
        transactionDetail.name = "detail"
        transactionDetail.type = .string
        
        let transactionPrice = NSAttributeDescription()
        transactionPrice.name = "transactionPrice"
        transactionPrice.type = .string
        
        let dateTimeTransactionAttribute = NSAttributeDescription();
        dateTimeTransactionAttribute.name = "dateTime"
        dateTimeTransactionAttribute.type = .date
        
        let descriptionTransactionAttribute = NSAttributeDescription();
        descriptionTransactionAttribute.name = "descriptionTransaction"
        descriptionTransactionAttribute.type = .string

        dateTransactionEntity.properties.append(descriptionTransactionAttribute)
        dateTransactionEntity.properties.append(dateIdAttribute)
        dateTransactionEntity.properties.append(transactionDetail)
        dateTransactionEntity.properties.append(transactionPrice)
        dateTransactionEntity.properties.append(dateTimeTransactionAttribute)
        
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
        dateTransactionRelation.inverseRelationship = userRelation;
        
        userEntity.properties.append(userRelation)
        dateTransactionEntity.properties.append(dateTransactionRelation)
        
        // ~Unused table just incase if change
//        let TransactionEntity = NSEntityDescription();
//        TransactionEntity.name = "TransactionEntity"
//        TransactionEntity.managedObjectClassName = "TransactionEntity"

//        let TransactionId = NSAttributeDescription()
//        TransactionId.name = "id"
//        TransactionId.type = .uuid
        
        
        
//        TransactionEntity.properties.append(TransactionId)
//        TransactionEntity.properties.append(TransactionDetail)
//        TransactionEntity.properties.append(transactionPrice)
//        TransactionEntity.properties.append(dateTimeTransactionAttribute)
        
//        let dateToTransactionRelation = NSRelationshipDescription();
//
//        dateToTransactionRelation.name = "dateToTransaction"
//        dateToTransactionRelation.destinationEntity = TransactionEntity;
//        dateToTransactionRelation.maxCount = 0
//        dateToTransactionRelation.minCount = 0
//
//        let transactionToDateRelation = NSRelationshipDescription();
//
//        transactionToDateRelation.name = "transactionToDate"
//        transactionToDateRelation.destinationEntity = dateTransactionEntity
//        transactionToDateRelation.maxCount = 1;
//        transactionToDateRelation.minCount = 1;
//
//        dateTransactionEntity.properties.append(dateToTransactionRelation);
//        TransactionEntity.properties.append(transactionToDateRelation);
        
//
//        let daytransactionTotal = NSAttributeDescription();
        
        // Model Creation
        
        model = NSManagedObjectModel()
        model.entities.append(userEntity)
        model.entities.append(dateTransactionEntity)

        
        

        
    }
}
