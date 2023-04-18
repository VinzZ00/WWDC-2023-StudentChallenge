//
//  user.swift
//  WWDCStudentChallenge
//
//  Created by Elvin Sestomi on 01/04/23.
//

import Foundation

class Data : ObservableObject {
    @Published var userName = "";
    @Published var financialConcept : String?
    @Published var salary : String = ""
    @Published var currentUser : User?
    @Published var moneyToPayforLoan : Double = 0
    @Published var moneyToPrimaryNeeds : Double = 0
    @Published var logout : Bool = false;
}
