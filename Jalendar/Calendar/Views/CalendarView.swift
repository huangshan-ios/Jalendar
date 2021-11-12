//
//  CalendarView.swift
//  Jalendar
//
//  Created by Son Hoang on 08/11/2021.
//

import UIKit

open class CalendarView: UIView {
    
    private lazy var weekdayView: WeekdayView = {
        let weekdayView = WeekdayView()
        return weekdayView
    }()
    
    private lazy var monthView: MonthView = {
        let monthView = MonthView()
        return monthView
    }()
    
    private var referenceDate: Date? = Date()
    
    public var config: CalendarConfig = CalendarConfig()
    
    public var delegate: CalendarDelegate?
    public var dataSource: CalendarDataSource?
    
    public func drawCalendar(with calendarConfig: CalendarConfig, at date: Date) {
        
        referenceDate = date
        config = calendarConfig
        
        removeAllContentView()
        setupUI()
        setupCallbackData()
        drawUI()
        
    }
    
    public func refreshCalendar() {
        
        guard let referenceDate = referenceDate else {
            return
        }
        
        if config.calendar.isShowWeekDayView {
            weekdayView.redrawWeekViewView()
        }
        
        monthView.redrawMonthView(referenceDate)
        
    }
    
    public func nextMonth() {
        
        guard let nextMonth = referenceDate?.nextMonth else {
            return
        }
        
        referenceDate = nextMonth
        monthView.redrawMonthView(nextMonth, isRedraw: true)
        
    }
    
    public func previousMonth() {
        
        guard let previousMonth = referenceDate?.previousMonth else {
            return
        }
        
        referenceDate = previousMonth
        monthView.redrawMonthView(previousMonth, isRedraw: true)
        
    }
    
    public func setSelectedDate(_ date: Date) {
        
        monthView.setSelectedDate(date)
    }
    
    public func getDateView(_ index: ItemViewIndex) -> UIView? {
        
        return monthView.getDateView(at: index)
        
    }
    
    private func removeAllContentView() {
        
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
    }

}

// MARK: - Setup functions
extension CalendarView {

    private func setupUI() {
        
        if config.calendar.isShowWeekDayView {
            weekdayView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(weekdayView)
            
            let height = dataSource?.heightForWeekdayView() ?? 0.0
            
            NSLayoutConstraint.activate([
                weekdayView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                weekdayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                weekdayView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                weekdayView.heightAnchor.constraint(equalToConstant: height)
            ])
        }
        
        monthView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(monthView)
        
        let monthTopAnchor = config.calendar.isShowWeekDayView ? weekdayView.bottomAnchor : topAnchor
        
        NSLayoutConstraint.activate([
            monthView.topAnchor.constraint(equalTo: monthTopAnchor, constant: 0),
            monthView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            monthView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            monthView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
        
    }
    
    private func setupCallbackData() {
        
        if config.calendar.isShowWeekDayView {
            weekdayView.onGetWeekdayView = dataSource?.weekDayView(at:size:)
        }
        
        monthView.onGetDateView = dataSource?.dateView(for:date:rect:)
        monthView.onGetSelectedDateView = dataSource?.selectedDateView(at:)
        
        monthView.onTap = delegate?.tap(at:index:point:)
        monthView.onDoubleTap = delegate?.doubleTap(at:index:point:)
        monthView.onLongPress = delegate?.longPress(at:index:point:)
        
    }
    
    private func drawUI() {
        
        guard let referenceDate = referenceDate else {
            return
        }
        
        if config.calendar.isShowWeekDayView {
            weekdayView.drawWeekdayView(with: config.week)
        }
        
        monthView.drawMonthView(with: referenceDate, and: config)
        
    }
}
