//
//  VerticalCalendar.swift
//  DemoCalendar
//
//  Created by Vimal Das on 09/10/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit
import VACalendar


class VerticalCalendar: UIView {
    
    private var calendarView: VACalendarView!
    
    @IBInspectable var leftinset: CGFloat = 10.0
    
    @IBInspectable var rightinset: CGFloat = 10.0
    
    @IBInspectable var monthTitleFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    @IBInspectable var monthTitleColor: UIColor = .black
    
    @IBInspectable var selectionColor: UIColor = .red
    
    private var weekDaysView: VAWeekDaysView!
    
    private let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCalendar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCalendar()
    }

    private func setupCalendar() {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        weekDaysView = VAWeekDaysView(frame: CGRect(x: 10, y: 0, width: self.frame.width, height: 80))
        let appereance = VAWeekDaysViewAppearance(symbolsType: .short, calendar: defaultCalendar)
        weekDaysView.appearance = appereance
        self.addSubview(weekDaysView)

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        
        let startDate = formatter.date(from: "01.01.2015")!
        let endDate = formatter.date(from: "01.01.2021")!
        
        let calendar = VACalendar(
            startDate: startDate,
            endDate: endDate,
            calendar: defaultCalendar
        )
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = false
        calendarView.selectionStyle = .single
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .vertical
        calendarView.setSupplementaries([
            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
            ])
        self.addSubview(calendarView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if calendarView.frame == .zero {
            weekDaysView.frame = CGRect(
                x: 0,
                y: 0,
                width: self.frame.width,
                height: 80
            )
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: self.frame.width,
                height: self.frame.height - weekDaysView.frame.maxY
            )
            calendarView.setup()
        }
    }
    
   
    
}
extension VerticalCalendar: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return leftinset
    }
    
    func rightInset() -> CGFloat {
        return rightinset
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return monthTitleFont
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return monthTitleColor
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
    func verticalMonthDateFormater() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter
    }
    
}

extension VerticalCalendar: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return selectionColor
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension VerticalCalendar: VACalendarViewDelegate {
    
    func selectedDate(_ date: Date) {
        print(date)
    }
    
}
