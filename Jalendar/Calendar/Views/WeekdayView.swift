//
//  WeekdayView.swift
//  Jalendar
//
//  Created by Son Hoang on 11/11/2021.
//

import UIKit

open class WeekdayView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var config: CalendarConfig.Week = CalendarConfig.Week()
    
    private var isDrawWeekday: Bool = false
    private var isRefreshWeekday: Bool = false
    
    var onGetWeekdayView: ((Int, CGSize) -> UIView)?
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !isDrawWeekday || isRefreshWeekday else {
            return
        }
        
        removeAllContentView()
        
        drawWeekDays()
    }
    
    public func drawWeekdayView(with weekConfig: CalendarConfig.Week) {
        config = weekConfig
        
        setNeedsDisplay()
    }
    
    public func refreshWeekViewView() {
        isRefreshWeekday = true
        setNeedsDisplay()
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    private func drawWeekDays() {
        guard subviews.contains(stackView) else {
            return
        }
        
        var index = config.startDayOfWeek.rawValue - 1
        let size = CGSize(width: stackView.frame.size.width / 7, height: stackView.frame.size.height)
        while stackView.arrangedSubviews.count < 7 {
            if let weekDayView = onGetWeekdayView?(index, size) {
                stackView.addArrangedSubview(weekDayView)
            }
            index = index == (WeekDay.allCases.count - 1) ? 0 : index + 1
        }
    }
    
    private func removeAllContentView() {
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
}
