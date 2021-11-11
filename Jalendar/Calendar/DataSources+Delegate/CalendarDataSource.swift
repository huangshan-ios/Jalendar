//
//  CalendarDataSource.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public protocol CalendarDataSource {
    
    func heightForWeekdayView() -> CGFloat
    
    func weekDayView(at index: Int, size: CGSize) -> UIView
    
    func dateView(for index: ItemViewIndex, date: Date, rect: CGRect) -> UIView
    
    func selectedDateView(at rect: CGRect) -> UIView
    
}

public extension CalendarDataSource {
    func heightForWeekdayView() -> CGFloat {
        return 24.0
    }
    
    func weekDayView(at index: Int, size: CGSize) -> UIView {
        return UIView(frame: CGRect(origin: .zero, size: size))
    }
    
    func selectedDateView(at rect: CGRect) -> UIView {
        return UIView(frame: rect)
    }
}
