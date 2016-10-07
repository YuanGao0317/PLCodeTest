//
//  PLAPIService.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import Foundation

protocol PLAPIService {
    func fetchBooks(completion:() -> ())
    func addBook(completion:() -> ())
    func getBook(url: String, completion:() -> ())
    func updateBook(url: String, completion:() -> ())
    func deleteBook(url: String, completion:() -> ())
    func deleteBooks(completion:() -> ())
}

class APIServiceController: PLAPIService {
    
    func fetchBooks(completion: () -> ()) {
        
    }
    
    func addBook(completion:() -> ()) {
        
    }
    
    func getBook(url: String, completion:() -> ()) {
        
    }
    
    func updateBook(url: String, completion:() -> ()) {
        
    }
    
    func deleteBook(url: String, completion:() -> ()) {
        
    }
    
    func deleteBooks(completion:() -> ()) {
        
    }
}