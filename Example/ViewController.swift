//
//  ViewController.swift
//  Example
//
//  Created by Son Hoang on 12/11/2021.
//

import UIKit
import Jalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var calendarView: CalendarView!
    
    private lazy var calendarConfig: CalendarConfig = {
        return CalendarConfigBuilder.makeBuilder()
            .showSelectedView(true)
            .setCustomGesture([.tap, .longPress])
            .setCustomizeDateView(true)
            .setSelectDateOfDifferentMonth(true)
            .showWeekdayView(true)
            .setStartDayOfWeek(.mon)
            .build()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        calendarView.drawCalendar(with: calendarConfig, at: Date())
    }
    
    private func setupCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else {return}
            self.calendarView.refreshCalendar()
        }, completion: nil)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        calendarView.nextMonth()
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        calendarView.previousMonth()
    }
    
}

extension ViewController: CalendarDataSource, CalendarDelegate {
    func tap(at date: Date, index: ItemViewIndex, point: CGPoint) {
        print("Tap at \(date)")
    }
    
    func heightForWeekdayView() -> CGFloat {
        return 24.0
    }
    
    func weekDayView(at index: Int, size: CGSize) -> UIView {
        let weekdayView = WeekDayView(frame: CGRect(origin: .zero, size: size))
        let weekDayStrings: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        weekdayView.setTitle("\(weekDayStrings[index])")
        return weekdayView
    }
    
    func dateView(for index: ItemViewIndex, date: Date, rect: CGRect) -> UIView {
        let dateview = DateView(frame: rect)
        dateview.configCell(date: date)
        return dateview
    }
    
    func selectedDateView(at rect: CGRect) -> UIView {
        let selectedDateView = SelectedDateView(frame: rect)
        selectedDateView.draw(rect)
        return selectedDateView
    }
}
