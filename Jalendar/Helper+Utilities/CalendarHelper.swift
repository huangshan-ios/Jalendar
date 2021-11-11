//
//  CalendarHelper.swift
//  Jalendar
//
//  Created by Son Hoang on 12/11/2021.
//

import UIKit

struct CalendarHelper {
    static func getAllDateInMonth(from startOfMonth: Date, to endOfMonth: Date, startDayOfWeek: Int = 0) -> [[Date]] {
        var dates: [Date] = []
        // Get all date in month
        var date = startOfMonth
        while date <= endOfMonth {
            dates.append(date)
            date = date.tomorrow
        }
        // Get all date show in last month
        let startDayOfWeek = startDayOfWeek
        guard let weekDayOfFirstDay = dates.first?.weekday else { return [[]] }
        let numberDatesInsert = startDayOfWeek <= weekDayOfFirstDay ? weekDayOfFirstDay - startDayOfWeek : 7 - startDayOfWeek + weekDayOfFirstDay
        for _ in 0..<numberDatesInsert {
            dates.insert(dates[0].yesterday, at: 0)
        }
        // Get all date show in next month
        while dates.count % 7 != 0 {
            dates.append(dates[dates.count - 1].tomorrow)
        }
        return stride(from: 0, to: dates.count, by: 7).map({ Array(dates[$0..<$0+7]) })
    }
    
    static func isReferenceDateValid(referenceDate: Date) -> Bool {
        return referenceDate >= Constants.minDate && referenceDate <= Constants.maxDate
    }
}
