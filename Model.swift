//
//  Employee.swift
//  Punching
//
//  Created by Ray on 2017/2/6.
//  Copyright © 2017年 kuas. All rights reserved.
//

import Foundation

var Employees = [Employee]()

class Employee {
    var id:String?
    var name:String?
    var offWork:String?
    var onWork:String?
    var index:Int?
    init() {
        
    }
}
class Punching {
    var year:String?
    var month:String?
    var day:String?
    var offWork:String?
    var onWork:String?
    var totalTime:Float?
    init() {
        
    }
}

class Month {
    var year:String?
    var month:String?
    var days:String?
    init() {
        
    }
}

func getNow() ->String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = NSTimeZone(name: "UTC+8") as TimeZone!
    let timeStamp = dateFormatter.string(from: date as Date)
    return timeStamp
}

func getNowDate() ->String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    dateFormatter.timeZone = NSTimeZone(name: "UTC+8") as TimeZone!
    let timeStamp = dateFormatter.string(from: date as Date)
    return timeStamp
}

func convertDateFormater(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    dateFormatter.timeZone = NSTimeZone(name: "UTC+8") as TimeZone!
    
    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return Date()
    }
    return date
}

func convertDayFormater(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.timeZone = NSTimeZone(name: "UTC+8") as TimeZone!
    
    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return Date()
    }
    return date
}
