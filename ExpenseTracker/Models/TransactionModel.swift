//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let ammount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPanding: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    
    var dateParsed: Date {
        date.dateParsed()
    }
     
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? ammount : -ammount
    }
}

enum TransactionType: String {
    case debt = "debt"
    case credit = "credit"
    
    
}
