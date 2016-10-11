//
//  PLDateFormattor.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
import UIKit

enum PLFormatter {
  case lastCheckedOut, stringToDate, currentDate
}

extension PLFormatter {
  func formatted(from lastCheckedOutBy: String, and lastCheckedOut: String) -> String {
    if self == .lastCheckedOut &&
      lastCheckedOutBy != "" &&
      lastCheckedOut != ""
    {
      return lastCheckedOutBy + " @ " + lastCheckedOut
    } else {
      return ""
    }
  }
  
  func formattedCurrentDate() -> String {
    if self == .currentDate {
      let currentDate = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
      formatter.locale = Locale.current
      return formatter.string(from: currentDate)
    } else {
      return ""
    }
  }
  
  func formatted(from string: String) -> String {
    if self == .stringToDate {
      let dateFormatter = DateFormatter()
//      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      if let date = dateFormatter.date(from: string) {
        let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .long
              dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: date)
      } else {
        return ""
      }
    } else {
      return ""
    }
  }
}

