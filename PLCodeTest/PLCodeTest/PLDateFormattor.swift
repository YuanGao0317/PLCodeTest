//
//  PLDateFormattor.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

enum PLFormattor {
  case lastCheckedOut
}

extension PLFormattor {
  func formatted(from lastCheckedOutBy: String, lastCheckedOut: String) -> String {
    switch self {
    case .lastCheckedOut:
      
      return ""
    }
  }
}
