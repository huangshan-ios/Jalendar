//
//  CalendarConfigBuilder.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

public protocol ConfigBuilder {
    
    static func makeBuilder() -> CalendarConfigBuilder
    
    func enableSelectedView(_ isEnable: Bool) -> CalendarConfigBuilder
    
    func enableEventView(_ isEnable: Bool) -> CalendarConfigBuilder
        
    func enableWeekDayView(_ isEnable: Bool) -> CalendarConfigBuilder
    
    func enableCustomizeDateView(_ isEnable: Bool) -> CalendarConfigBuilder
    
    func enableSelectDateOfDifferentMonth(_ isEnable: Bool) -> CalendarConfigBuilder
    
    func setTimeForAnimateDetailView(_ interval: TimeInterval) -> CalendarConfigBuilder
    
    func setStartDayOfWeek(_ weekDay: WeekDay) -> CalendarConfigBuilder
    
    func setWeekViewHeight(_ height: CGFloat) -> CalendarConfigBuilder
    
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
    
    public func enableSelectedView(_ isEnable: Bool) -> CalendarConfigBuilder {
        calendarConfig.isDrawSelectedView = isEnable
        return self
    }
    
    public func enableEventView(_ isEnable: Bool) -> CalendarConfigBuilder {
        calendarConfig.isDrawEventView = isEnable
        return self
    }
    
    public func enableWeekDayView(_ isEnable: Bool) -> CalendarConfigBuilder {
        calendarConfig.isDrawWeekDayView = isEnable
        return self
    }
    
    public func enableCustomizeDateView(_ isEnable: Bool) -> CalendarConfigBuilder {
        calendarConfig.isCustomizeDateView = isEnable
        return self
    }
    
    public func enableSelectDateOfDifferentMonth(_ isEnable: Bool) -> CalendarConfigBuilder {
        calendarConfig.canSelectedDifferrentMonthDate = isEnable
        return self
    }
    
    public func setTimeForAnimateDetailView(_ interval: TimeInterval) -> CalendarConfigBuilder {
        calendarConfig.timeAnimateDetailView = interval
        return self
    }
    
    public func setStartDayOfWeek(_ weekDay: WeekDay) -> CalendarConfigBuilder {
        calendarConfig.startDayOfWeek = weekDay
        return self
    }
    
    public func setWeekViewHeight(_ height: CGFloat) -> CalendarConfigBuilder {
        calendarConfig.weekDayStackViewHeight = height
        return self
    }
    
    public func build() -> CalendarConfig {
        return calendarConfig
    }
    
}
