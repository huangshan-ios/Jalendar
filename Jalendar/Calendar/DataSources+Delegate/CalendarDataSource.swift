//
//  CalendarDataSource.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public protocol CalendarDataSource {
    
    func weekDayStrings() -> [String]
    
    func weekDayView(at index: Int, title: String) -> UIView
    
    func dateView(for index: ItemViewIndex, date: Date, rect: CGRect) -> UIView
    
    func selectedDateView(at rect: CGRect) -> UIView
    
}
