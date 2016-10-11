//
//  PLDateFormattor.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
import UIKit

enum PLFormatter {
  case lastCheckedOut, dateToString
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
  
  func formatted(from date: Date) -> String {
    if self == .dateToString {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      dateFormatter.timeStyle = .short
      return dateFormatter.string(from: date)
    } else {
      return ""
    }
  }
}

