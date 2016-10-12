//
//  PLDateFormattor.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
import UIKit

struct PLFormatter {
  static func formattedLastCheckedOut(fromLastCheckedOutBy lastCheckedOutBy: String, andLastCheckedOut lastCheckedOut: String) -> String {
    if lastCheckedOutBy != "" &&
       lastCheckedOut != ""
    {
      return lastCheckedOutBy + " @ " + lastCheckedOut
    } else {
      return ""
    }
  }
  
  static func formattedCurrentDate() -> String {
    let currentDate = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
    formatter.locale = Locale.current
    return formatter.string(from: currentDate)
  }
  
  static func formattedDate(from string: String) -> String {
    let dateFormatter = DateFormatter()
//          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz" // for local api server
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let date = dateFormatter.date(from: string) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      dateFormatter.timeStyle = .medium
      return dateFormatter.string(from: date)
    } else {
      return ""
    }
  }
  
}

