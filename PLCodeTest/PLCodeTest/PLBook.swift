//
//  PLBook.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
import SwiftyJSON

struct PLBook {
  let id: Int?
  let author: String
  let categories: String
  let lastCheckedOut: String
  let lastCheckedOutBy: String
  let publisher: String
  let title: String
  let url: String
  
  // MARK: - Initiallizers
  init(
    author: String,
    categories: String,
    lastCheckedOut: String,
    lastCheckedOutBy: String,
    publisher: String,
    title: String,
    url: String
    ) throws
  {
    
    guard
      PLValidator
        .required
        .isValid([title, author])
      else { throw PLValidationError.isEmpty
    }
    
    self.id = nil
    self.author = author
    self.categories = categories
    self.lastCheckedOut = lastCheckedOut
    self.lastCheckedOutBy = lastCheckedOutBy
    self.publisher = publisher
    self.title = title
    self.url = url
  }
  
  init(json: JSON) {
    self.id = json["id"].intValue
    self.author = json["author"].stringValue
    self.categories = json["categories"].stringValue
    self.lastCheckedOut = json["lastCheckedOut"].stringValue
    self.lastCheckedOutBy = json["lastCheckedOutBy"].stringValue
    self.publisher = json["publisher"].stringValue
    self.title = json["title"].stringValue
    self.url = json["url"].stringValue
  }
  
}
