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
    @Published var salary : Double?
    @Published var newUser : User?
}
