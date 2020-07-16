//
//  Date+Extensions.swift
//  CarFit
//
//  Created by AA/MP/05 on 08/07/20.
//  Copyright © 2020 Test Project. All rights reserved.
//

import UIKit

extension Date {
    
    var calendar : Calendar {
        return Calendar.init(identifier: .gregorian)
    }
    
    // Only month and year formatter
    var monthYearDateFormatter : DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MMM yyyy"
        return dateformat
    }
    
    var dateYearFormatter : DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat
    }
    
    var dateFormatter : DateFormatter {
        return DateFormatter()
    }
    
    var isToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    var isCurrentMonth: Bool {
        return monthYearDateFormatter.string(from: self) == monthYearDateFormatter.string(from: Date())
    }
    
    // Date -> String
    var string: String {
        return dateYearFormatter.string(from: self)
    }
    
    // get day from date
    var day: String {
        return String(Calendar.current.component(.day, from: self))
    }
    
    var dayInInt: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    // this is week day like: Mon, Tue, wed
    var weekDay: String {
        let weekDay = Calendar.current.component(.weekday, from: self) - 1
        return dateFormatter.shortWeekdaySymbols[weekDay].uppercased()
    }
    
    // Month statring date
    var startOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }

    // total number of days in month
    func numDaysInMonth() -> Int {
        let range : NSRange = (calendar as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        let numberOfDaysInMonth = range.length
        return numberOfDaysInMonth
    }
    
    // check if any date is selectd in month
    func isSelectedMonth(date: Date) -> Bool {
        return monthYearDateFormatter.string(from: self) == monthYearDateFormatter.string(from: date)
    }
    
    func nextMonth() -> Date {
        return calendar.date(byAdding: .month, value: 1, to: self)!
    }
    
    func previousMonth() -> Date {
        return calendar.date(byAdding: .month, value: -1, to: self)!
    }
    
    // Get  fromatted month and year string from Date
    func getMonthAndYear() -> String {
        return monthYearDateFormatter.string(from: self)
    }
    
    // Get full date month year string for title
    func getDateWithYear() -> String {
        return dateYearFormatter.string(from: self)
    }
    
    // get all dates from current month
    func getAllDates() -> [Date] {
        
        let numberOfDays: Int = numDaysInMonth()
        var offset = DateComponents()
        var dates: [Date] = [startOfMonth]
        
        for i in 1..<numberOfDays {
            offset.day = i
            if let nextDay = calendar.date(byAdding: offset, to: startOfMonth) {
                dates.append(nextDay)
            }
        }
        return dates
    }
}

extension String {
    
    var timeFormatter : DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm"
        return dateformat
    }
    
    var dateTimeformatter : DateFormatter {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateformat
    }
    
    func getFormattedTime() -> String {
        if let timeData = dateTimeformatter.date(from: self) {
            return timeFormatter.string(from: timeData)
        }
        return ""
    }
    
    func getFormattedDate() -> String {
        if let timeData = dateTimeformatter.date(from: self) {
            return timeData.string
        }
        return ""
    }
}
