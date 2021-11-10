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
    
    public var config: CalendarConfig = CalendarConfig()
    
    public var delegate: CalendarDelegate?
    public var dataSource: CalendarDataSource?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    private func initView() {
    }
    
}

// MARK: - Setup functions
extension CalendarView {
}
