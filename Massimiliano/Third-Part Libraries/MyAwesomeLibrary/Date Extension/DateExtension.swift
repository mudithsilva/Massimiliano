//
//  DateExtension.swift
//  EventApp
//
//  Created by Mudith Chathuranga on 10/10/18.
//  Copyright © 2018 Webnatics. All rights reserved.
//

import Foundation

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    func tokenOutDate(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: Date())!
    }
    
    func monthsBack(months: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: -months, day: 0), to: self)!
    }
    
    func yearsBack(years: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: -years), to: self)!
    }
    
    func startOfYear() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func startOfTheDay() -> Date {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        comp.timeZone = TimeZone(abbreviation: "UTC")!
        return Calendar.current.date(from: comp)!
    }
    
    func startOfTheDayGMT() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        return calendar.date(bySettingHour: 00, minute: 00, second: 0, of: self)!
    }
    
    func getGMTTimeDate() -> Date {
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        comp.calendar = Calendar.current
        comp.timeZone = TimeZone(abbreviation: "GMT")!
        return Calendar.current.date(from: comp)!
    }

    func endOfYear() -> Date {
        return Calendar.current.date(byAdding: DateComponents(year: 1, day: -1), to: self.startOfYear())!
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}


//////  Loop through Date Range  //////
//extension Date: Strideable {
//    public func advanced(by n: Int) -> Date {
//        return Calendar.current.date(byAdding: .day, value: n, to: self) ?? self
//    }
//
//    public func distance(to other: Date) -> Int {
//        return Calendar.current.dateComponents([.day], from: other, to: self).day ?? 0
//    }
//}
