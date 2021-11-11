//
//  Date+Extensions.swift
//  Jalendar
//
//  Created by Son Hoang on 11/11/2021.
//

import Foundation

extension Date {
    
    var previousSecond: Date {
        return Calendar.gregorian.date(byAdding: .second, value: -1, to: self) ?? self
    }
    
    var yesterday: Date {
        return Calendar.gregorian.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    var tomorrow: Date {
        return Calendar.gregorian.date(byAdding: .day, value: 1, to: self) ?? self
    }
    
    var weekday: Int {
        /* 1: Sun, 2: Mon, 3: Tue, 4: Wed, 5: Thu, 6: Fri, 7: Sat */
        return Calendar.gregorian.component(.weekday, from: self)
    }
    
    var startOfMonth: Date {
        let components = Calendar.gregorian.dateComponents([.year, .month], from: self)
        return Calendar.gregorian.date(from: components) ?? self
    }
    
    var endOfMonth: Date {
        return startOfMonth.nextMonth.previousSecond
    }
    
    var month: Int {
        return Calendar.gregorian.component(.month, from: self)
    }
    
    var nextMonth: Date {
        return Calendar.gregorian.date(byAdding: .month, value: 1, to: self) ?? self
    }
    
    var previousMonth: Date {
        return Calendar.gregorian.date(byAdding: .month, value: -1, to: self) ?? self
    }

}
