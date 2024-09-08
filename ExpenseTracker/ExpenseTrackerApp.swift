//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    //let persistenceController = PersistenceController.shared
    @StateObject var transactionLstVM = TransactionLstViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionLstVM)
        }
    }
}
