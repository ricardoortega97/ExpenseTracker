//
//  TransactionLst.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/8/24.
//

import SwiftUI

struct TransactionLst: View {
    @EnvironmentObject var transactionLstVM: TransactionLstViewModel
    
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Group
                ForEach(Array(transactionLstVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        // MARK: Transation List
                        ForEach(transactions) { transactions in
                            TransactionRow(transaction: transactions)
                        }
                    } header: {
                        // MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden) //hides the line below the month
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Previews
struct TransactionLst_Previews: PreviewProvider {
    static let transactionsLstVM: TransactionLstViewModel = {
        let transactionLstVM = TransactionLstViewModel()
        transactionLstVM.transactions = transactionsListPreviewData
        return transactionLstVM
    }()
    
    static var previews: some View {
        NavigationView{
            TransactionLst()
        }
        .environmentObject(transactionsLstVM)
    }
}
