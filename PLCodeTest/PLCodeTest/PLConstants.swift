//
//  PLConstants.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import Material

// MARK: - API Constants
enum API {
  static let server  = "http://prolific-interview.herokuapp.com/57f7b32592f7ad0009dc8656"
  static let books = server + "/books/"
  static let cleanBooks = server + "/clean/"
}

// MARK: - Global Constants
enum Constants {
  static let cellReuseIdentifier = "cell"
  static let addBookSegue = "AddBookSegue"
  static let showBookSegue = "ShowBookDetailSegue"
  static let PLNewBookFormView = "PLNewBookFormView"
  static let PLBookDetailView = "PLBookDetailView"
}

// MARK: - Colors
struct PLColor {
  static let cleanRed = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 1.0)
  static let global = cleanRed
  static let white = UIColor.white
}

