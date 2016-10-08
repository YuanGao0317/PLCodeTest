//
//  PLValidator.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//


enum Validator {
  case required
}

extension Validator {
  func isValid(_ attrs: [String]) -> Bool {
    switch self {
    case .required:
      let length = attrs.filter({ attr in attr == "" }).count
      return length != 0 ? false : true
    }
  }
}
