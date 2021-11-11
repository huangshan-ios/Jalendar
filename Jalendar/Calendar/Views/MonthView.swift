//
//  MonthView.swift
//  Jalendar
//
//  Created by Son Hoang on 11/11/2021.
//

import UIKit

public enum GestureType {
    case tap
    case doubleTap
    case longPress
}

open class MonthView: UIView {
    
    private lazy var tabGesture: UITapGestureRecognizer = {
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tabGesture.cancelsTouchesInView = false
        if config.gestures.contains(.doubleTap) {
            tabGesture.require(toFail: doubleTapGesture)
        }
        return tabGesture
    }()
    
    private lazy var doubleTapGesture: UITapGestureRecognizer = {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapHandler(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.cancelsTouchesInView = false
        return doubleTapGesture
        
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler(_:)))
        longPressGesture.cancelsTouchesInView = false
        return longPressGesture
    }()
    
    private var config: CalendarConfig.Month = CalendarConfig.Month()
    
    private var isDrawCalendar: Bool = false
    private var isRedrawMonthView: Bool = false
    
    private let borderTwoSideWidth: CGFloat = CalendarDefaultConfig.separatorLineWidth * 2
    private var dateViewWidth: CGFloat = 0.0
    private var dateViewHeight: CGFloat = 0.0
    
    private var allDateInMonth: DatesInMonth {
        guard let referenceDate = referenceDate else {
            print("Need set the reference date to draw the calendar")
            return []
        }
        return CalendarHelper.getAllDateInMonth(from: referenceDate.startOfMonth, to: referenceDate.endOfMonth,
                                                startDayOfWeek: startDayOfWeek)
    }
    private var referenceDate: Date? = Date()
    private var startDayOfWeek: Int = 0
    
    private var selectedDateView = UIView()
    
    private var selectedIndex: ItemViewIndex?
    
    var onTap: ((Date, ItemViewIndex, CGPoint) -> Void)?
    var onDoubleTap: ((Date, ItemViewIndex, CGPoint) -> Void)?
    var onLongPress: ((Date, ItemViewIndex, CGPoint) -> Void)?
    
    var onGetDateView: ((ItemViewIndex, Date, CGRect) -> UIView?)?
    var onGetSelectedDateView: ((CGRect) -> UIView?)?
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if allDateInMonth.count > 0 && (!isDrawCalendar || isRedrawMonthView) {
            
            isDrawCalendar = true
            
            isRedrawMonthView = false
            
            removeAllContentView()
            
            drawDateView(in: rect)
            
            drawSelectedDateView()
            
        }
    }
    
}

// MARK: - Setup functions
extension MonthView {
    
    public func drawMonthView(with referenceDate: Date,
                              and calendarConfig: CalendarConfig) {
        
        config = calendarConfig.month
        
        startDayOfWeek = calendarConfig.week.startDayOfWeek.rawValue
        
        addUserGesture()
        
        drawMonthView(with: referenceDate)
        
    }
    
    public func redrawMonthView(_ date: Date, isRedraw: Bool = false) {
        
        if isRedraw {
            selectedIndex = nil
        }
        
        isRedrawMonthView = true
        
        drawMonthView(with: date)
        
    }
    
    public func setSelectedDate(_ date: Date) {
        
        guard let index = getViewIndex(at: date) else {
            return
        }
        
        selectedIndex = index
        
        drawSelectedDateView()
        
    }
    
    private func drawMonthView(with date: Date) {
        
        referenceDate = date
                
        setNeedsDisplay()
        
    }
    
}

// MARK: - Date View
extension MonthView {
    private func drawDateView(in rect: CGRect) {
        let dateInMonth = allDateInMonth
        let weekCount = dateInMonth.count
        let daysInWeek = dateInMonth.first?.count ?? 0
        let separatorLineWidth = CalendarDefaultConfig.separatorLineWidth
        
        dateViewWidth = (rect.width / CGFloat(daysInWeek)) - borderTwoSideWidth
        dateViewHeight = (rect.height / CGFloat(weekCount)) - borderTwoSideWidth
        
        var viewPoint = CGPoint(x: rect.origin.x + separatorLineWidth, y: rect.origin.y + separatorLineWidth)
        
        for (weakIndex, week) in dateInMonth.enumerated() {
            for (dayIndex, date) in week.enumerated() {
                
                let xPoint = rect.width / CGFloat(daysInWeek)
                let yPoint = rect.height / CGFloat(weekCount)
                let xPos = (xPoint * CGFloat(dayIndex)) + separatorLineWidth
                let yPos = (yPoint * CGFloat(weakIndex)) + separatorLineWidth
                
                viewPoint = CGPoint(x: xPos, y: yPos)
                
                let dateViewRect = CGRect(origin: viewPoint, size: CGSize(width: dateViewWidth, height: dateViewHeight))
                addSubview(getDateView(from: date, bound: dateViewRect))
                
            }
        }
    }
    
    private func getDateView(from date: Date, bound: CGRect) -> UIView {
        guard config.isCustomizeDateView, let viewIndex = getViewIndex(at: date) else {
            return UIView(frame: bound)
        }
        
        return onGetDateView?(viewIndex, date, bound) ?? UIView()
    }
}

// MARK: - Selected Date View
extension MonthView {
    
    private func drawSelectedDateView(byLocation point: CGPoint) {
        if config.isShowSelectedView {
            
            selectedDateView.removeFromSuperview()
            
            let size = CGSize(width: dateViewWidth + borderTwoSideWidth, height: dateViewHeight + borderTwoSideWidth)
            
            selectedDateView = onGetSelectedDateView?(CGRect(origin: point, size: size)) ?? UIView()
            addSubview(selectedDateView)
            
        }
    }
    
    private func drawSelectedDateView() {
        if let index = selectedIndex, config.isShowSelectedView {
            
            selectedDateView.removeFromSuperview()
            
            let leftRightBorderWidth = borderTwoSideWidth * index.x
            let topBottomBorderWidth = borderTwoSideWidth * index.y
            
            let xPoint = (index.x * dateViewWidth) + leftRightBorderWidth
            let yPoint = (index.y * dateViewHeight) + topBottomBorderWidth
            
            let point = CGPoint(x: xPoint, y: yPoint)
            let size = CGSize(width: dateViewWidth + borderTwoSideWidth, height: dateViewHeight + borderTwoSideWidth)
            
            selectedDateView = onGetSelectedDateView?(CGRect(origin: point, size: size)) ?? UIView()
            
            addSubview(selectedDateView)
            
        }
    }
    
}

// MARK: - Gestures
extension MonthView {
    private func addUserGesture() {
        config.gestures.forEach { gesture in
            switch gesture {
            case .tap:
                addGestureRecognizer(tabGesture)
            case .doubleTap:
                addGestureRecognizer(doubleTapGesture)
            case .longPress:
                addGestureRecognizer(longPressGesture)
            }
        }
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer) {
        let location = getGestureLocation(atPoint: sender.location(in: sender.view))
        let selectedDate = getDate(at: location.index)
        if isIndexValid(location.index) {
            drawSelectedDateView(byLocation: location.point)
            onTap?(selectedDate, location.index, location.point)
            selectedIndex = location.index
        }
    }
    
    @objc private func doubleTapHandler(_ sender: UITapGestureRecognizer) {
        let location = getGestureLocation(atPoint: sender.location(in: sender.view))
        if isIndexValid(location.index) {
            drawSelectedDateView(byLocation: location.point)
            onDoubleTap?(getDate(at: location.index), location.index, location.point)
            selectedIndex = location.index
        }
    }
    
    @objc private func longPressHandler(_ sender: UILongPressGestureRecognizer) {
        let location = getGestureLocation(atPoint: sender.location(in: sender.view))
        if isIndexValid(location.index) {
            drawSelectedDateView(byLocation: location.point)
            onLongPress?(getDate(at: location.index), location.index, location.point)
            selectedIndex = location.index
        }
    }
}


// MARK: - Utilities Functions
extension MonthView {
    private func removeAllContentView() {
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}

// MARK: - Calculate Functions
extension MonthView {
    private func getGestureLocation(atPoint point: CGPoint) -> (index: ItemViewIndex, point: CGPoint) {
        
        let xPoint = (point.x.rounded(.down) / dateViewWidth).rounded(.down)
        let yPoint = (point.y.rounded(.down) / dateViewHeight).rounded(.down)
        
        let leftRightBorderWidth = borderTwoSideWidth * xPoint
        let topBottomBorderWidth = borderTwoSideWidth * yPoint
        
        let xPos = (xPoint * dateViewWidth) + leftRightBorderWidth
        let yPos = (yPoint * dateViewHeight) + topBottomBorderWidth
        
        return (index: (x: xPoint, y: yPoint), point: CGPoint(x: xPos, y: yPos))
    }
    
    private func getDate(at index: ItemViewIndex) -> Date {
        if allDateInMonth.count > 0 && isIndexValid(index) {
            let rowIndex = Int(index.y)
            let collumIndex = Int(index.x)
            return allDateInMonth[rowIndex][collumIndex]
        }
        return Date()
    }
    
    private func getViewIndex(at date: Date) -> ItemViewIndex? {
        if let xIndex = allDateInMonth.firstIndex(where: { $0.contains(date) }) {
            if let yIndex = allDateInMonth[xIndex].firstIndex(where: { $0 == date }) {
                return (x: CGFloat(xIndex), y: CGFloat(yIndex))
            }
        }
        return nil
    }
    
    private func isIndexValid(_ index: ItemViewIndex) -> Bool {
        let indexY = Int(index.y)
        let indexX = Int(index.x)
        if config.canSelectedDifferrentMonthDate {
            return indexY <= allDateInMonth.count - 1 && indexX <= allDateInMonth[indexY].count - 1
        }
        return isDateInThisMonth(index)
    }
    
    private func isDateInThisMonth(_ index: ItemViewIndex) -> Bool {
        let rowIndex = Int(index.y)
        let collumIndex = Int(index.x)
        if let referenceDate = referenceDate,
           rowIndex <= allDateInMonth.count - 1
            && collumIndex <= allDateInMonth[rowIndex].count - 1 {
            
            let date = allDateInMonth[rowIndex][collumIndex]
            if date.month == referenceDate.month {
                return true
            }
        }
        return false
    }
}
