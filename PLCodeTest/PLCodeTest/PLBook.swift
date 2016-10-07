//
//  PLBook.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import Foundation

struct Book {
    let author: String
    let categories: String?
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let publisher: String?
    let title: String
    let url: String?
    
    init(
        author: String,
        categories: String?,
        lastCheckedOut: String?,
        lastCheckedOutBy: String?,
        publisher: String?,
        title: String,
        url: String?
        )
    {
        self.author = author
        self.categories = categories
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
        self.title = title
        self.url = url
    }
}