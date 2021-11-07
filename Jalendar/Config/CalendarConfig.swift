//
//  CalendarConfig.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public class CalendarConfig {
    
    var isDrawSelectedView: Bool
    
    var isDrawEventView: Bool
        
    var isDrawWeekDayView: Bool
    
    var isCustomizeDateView: Bool
    
    var isCustomizeSelectedDateView: Bool
    
    var canSelectedDifferrentMonthDate: Bool
    
    var timeAnimateDetailView: TimeInterval
    
    var startDayOfWeek: WeekDay
    
    var weekDayStackViewHeight: CGFloat
    
    init() {
        isDrawSelectedView = true
        isDrawEventView = true
        isDrawWeekDayView = true
        isCustomizeDateView = false
        isCustomizeSelectedDateView = false
        canSelectedDifferrentMonthDate = true
        timeAnimateDetailView = 0.5
        startDayOfWeek = .mon
        weekDayStackViewHeight = CalendarDefaultConfig.weekDayStackViewHeight
    }
    
}
