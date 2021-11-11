//
//  CalendarConfigBuilder.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public protocol ConfigBuilder {
    
    static func makeBuilder() -> CalendarConfigBuilder
    
    func showSelectedView(_ isShowing: Bool) -> CalendarConfigBuilder
    
    func setCustomizeDateView(_ isCustomize: Bool) -> CalendarConfigBuilder
    
    func setSelectDateOfDifferentMonth(_ canSelect: Bool) -> CalendarConfigBuilder
    
    func setCustomGesture(_ gestures: [GestureType]) -> CalendarConfigBuilder
        
    func showWeekdayView(_ isShowing: Bool) -> CalendarConfigBuilder
    
    func setStartDayOfWeek(_ weekDay: WeekDay) -> CalendarConfigBuilder
        
    func build() -> CalendarConfig
    
}

public class CalendarConfigBuilder: ConfigBuilder {
    
    private let calendarConfig: CalendarConfig
    
    public static func makeBuilder() -> CalendarConfigBuilder {
        let builder = CalendarConfigBuilder(config: CalendarConfig())
        return builder
    }
    
    init(config: CalendarConfig) {
        calendarConfig = config
    }
    
    public func showSelectedView(_ isShowing: Bool) -> CalendarConfigBuilder {
        calendarConfig.month.isShowSelectedView = isShowing
        return self
    }
    
    public func setCustomizeDateView(_ isCustomize: Bool) -> CalendarConfigBuilder {
        calendarConfig.month.isCustomizeDateView = isCustomize
        return self
    }
    
    public func setSelectDateOfDifferentMonth(_ canSelect: Bool) -> CalendarConfigBuilder {
        calendarConfig.month.canSelectedDifferrentMonthDate = canSelect
        return self
    }
    
    public func setCustomGesture(_ gestures: [GestureType]) -> CalendarConfigBuilder {
        calendarConfig.month.gestures = gestures
        return self
    }
    
    public func showWeekdayView(_ isShowing: Bool) -> CalendarConfigBuilder {
        calendarConfig.calendar.isShowWeekDayView = isShowing
        return self
    }
    
    public func setStartDayOfWeek(_ weekDay: WeekDay) -> CalendarConfigBuilder {
        calendarConfig.week.startDayOfWeek = weekDay
        return self
    }
    
    public func build() -> CalendarConfig {
        return calendarConfig
    }
    
}
