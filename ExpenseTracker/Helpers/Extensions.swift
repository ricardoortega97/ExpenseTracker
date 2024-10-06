//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Ricardo Ortega on 9/7/24.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundColor = Color("Background")
    static let iconColor = Color("Icon")
    static let textColor = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}
extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date()}
        
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundededTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}

