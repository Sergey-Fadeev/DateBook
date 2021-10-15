//
//  CalendarHelper.swift
//  DateBook
//
//  Created by Sergey on 14.10.2021.
//

import Foundation
import UIKit

class CalendarHelper
{
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date
    {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func timeString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    
    func lastDateOfThePreviousMonth(date: Date) -> Date
    {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    
    func weekDay(date: Date) -> Int
    {
        let components = Calendar.current.component(.weekday, from: date) - 1
        var dayOfWeak = 0
        switch components {
        case 0:
            dayOfWeak = 6
        case 1:
            dayOfWeak = 0
        case 2:
            dayOfWeak = 1
        case 3:
            dayOfWeak = 2
        case 4:
            dayOfWeak = 3
        case 5:
            dayOfWeak = 4
        case 6:
            dayOfWeak = 5
        default:
            dayOfWeak = 0
        }
        return dayOfWeak
    }
    
    
    func collectionDate(day: Int, fullDate: Date) -> Date
    {
        let calendar = Calendar.current

        var dateComponents: DateComponents? = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: fullDate)

        dateComponents?.day = day

        let date: Date? = calendar.date(from: dateComponents!)
        
        return date!
    }
}
