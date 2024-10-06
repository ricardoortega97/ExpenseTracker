//
//  TransactionLstViewModel.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

//combine framework that turns any object into a publisher and notify its user of the state changes
final class TransactionLstViewModel: ObservableObject {
    //warpper class
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data  in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    //if both condition failed
                    dump(response) //great for logging objects
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
        //After getting the data, decode it into a data model with JSON
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                    //if failed
                case.failure(let error):
                    print("Error fetching transactions:, \(error)", error.localizedDescription) //provides the error code 
                case.finished:
                    print("Finished fecthing transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                //dump(self?.transactions)
            }
            .store(in: &cancellables)
    }

    func groupTransactionByMonth() -> TransactionGroup {
      //ensure the array is not empty
        guard !transactions.isEmpty else {return [:] } //returns the dictonary
        
        //Constant group call
        let groupTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupTransactions
    }
    
    func accumulateTransaction() -> TransactionPrefixSum{
        print("Accumulate Transaction")
        guard !transactions.isEmpty else {return [] }
        
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval: \(dateInterval)")
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter {$0.dateParsed == date && $0.isExpense}
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundededTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal: \(dailyTotal), sum: \(sum)")
            
        }
        return cumulativeSum
    }
}
