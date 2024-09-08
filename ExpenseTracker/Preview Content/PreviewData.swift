//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2020", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionsListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)

