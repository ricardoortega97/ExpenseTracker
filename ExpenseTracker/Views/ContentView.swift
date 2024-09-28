//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart
                    CardView{
                        VStack() {
                            ChartLabel("$900", type: .title)
                            
                            LineChart()
                        }
                        .background(Color.backgroundColor)
                    }
                    .data(demoData)
                    .chartStyle(ChartStyle(backgroundColor: Color.systemBackground,
                                           foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                    .frame(height: 300)
                    
                    
                    // MARK: Transaction List
                    RecentTransactionLst()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                Image(systemName: "bell.badge")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.iconColor, .primary)
                
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
    
}
struct ContentView_Previews: PreviewProvider {
    
    static let transactionsLstVM: TransactionLstViewModel = {
        //call the instance
        let transactionLstVM = TransactionLstViewModel()
        //push the data to the property
        transactionLstVM.transactions = transactionsListPreviewData
        return transactionLstVM
    }()
    static var previews: some View {
        ContentView()
        //call the instance of the Transaction list Model
            .environmentObject(transactionsLstVM)
    }
}
