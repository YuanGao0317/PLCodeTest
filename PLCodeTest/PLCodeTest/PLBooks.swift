//
//  PLBooks.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//


final class PLBooks {
    static let sharedInstance = PLBooks()
    
    lazy var apiService = APIServiceController()
    
    fileprivate init() {}
    
    func allBooks() -> ([PLBook], String) {
        
        return ([], "")
    }
    
    func getBook(_ url: String) -> (PLBook, String) {
        let book = PLBook(author: "a", categories: "", lastCheckedOut: "", lastCheckedOutBy: "", publisher: "", title: "t", url: "")
        
        return (book, "")
    }
    
    func updateBook(_ url: String) -> (PLBook, String) {
        let book = PLBook(author: "a", categories: "", lastCheckedOut: "", lastCheckedOutBy: "", publisher: "", title: "t", url: "")
        
        return (book, "")
    }
    
}
