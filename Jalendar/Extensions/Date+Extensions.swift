//
//  Date+Extensions.swift
//  Jalendar
//
//  Created by Son Hoang on 11/11/2021.
//

import Foundation

extension Date {
    var month: Int {
        return Calendar.gregorian.component(.month, from: self)
    }
}
