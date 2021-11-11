//
//  Date+Extensions.swift
//  Example
//
//  Created by Son Hoang on 12/11/2021.
//

import UIKit

extension Calendar {
    static var gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    var day: Int {
        return Calendar.gregorian.component(.day, from: self)
    }
}
