//
//  RecentTransactionLst.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/8/24.
//

import SwiftUI

struct RecentTransactionLst: View {
    @EnvironmentObject var transactonsLstVM: TransactionLstViewModel
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header Title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                // MARK: Header Link
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("Sell all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.textColor)
                }
                
            }
            .padding(.top)
            
            // MARK: Recent Transaction List
            ForEach(Array(transactonsLstVM.transactions.prefix(5).enumerated()), id: \.element) {index, transactions in
                TransactionRow(transaction: transactions)
                
                Divider()//render it if the index is 4
                    .opacity(index == 4 ? 0 : 1)
                
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
        
    }
}

struct RecentTransactionLst_Previews: PreviewProvider {
    static let transactionsLstVM: TransactionLstViewModel = {
        //call the instance
        let transactionLstVM = TransactionLstViewModel()
        //push the data to the property
        transactionLstVM.transactions = transactionsListPreviewData
        return transactionLstVM
    }()
    static var previews: some View {
        RecentTransactionLst()
            .environmentObject(transactionsLstVM)
    }
}
