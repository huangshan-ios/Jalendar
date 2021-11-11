//
//  CalendarConfig.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public class CalendarConfig {
    
    var calendar: Calendar = Calendar()
    
    var month: Month = Month()
    
    var week: Week = Week()
    
}

extension CalendarConfig {
    
    public struct Calendar {
        var isShowWeekDayView: Bool = true
    }
    
    public struct Month {
        var gestures: [GestureType] = [.tap]
        var isCustomizeDateView: Bool = false
        var isShowSelectedView: Bool = true
        var isCustomizeSelectedDateView: Bool = false
        var canSelectedDifferrentMonthDate: Bool = false
    }
    
    public struct Week {
        var startDayOfWeek: WeekDay = .mon
    }
    
}
