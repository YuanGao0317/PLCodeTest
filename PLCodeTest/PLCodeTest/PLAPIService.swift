//
//  PLAPIService.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import Alamofire
import SwiftyJSON


typealias done = Result<[PLBook]> -> Void

protocol PLAPIService {
	func fetchBooks(completion: done)
	func addBook(book: PLBook, completion:() -> ())
	func getBook(path: String, completion:() -> ())
	func updateBook(lastCheckedOutBy: String,
		lastCheckedOut: String,
		path: String,
		completion:() -> ()
	)
	func deleteBook(path: String, completion:() -> ())
	func deleteBooks(completion:() -> ())
}

final class APIServiceController: PLAPIService {
	
	
	func fetchBooks(completion: done) {
		//        Alamofire.request(.GET, API.books).responseJSON { (request, response, result) in
		//
		//            switch result {
		//            case .Success(let data):
		//                var books: [PLBook] = []
		//                let booksJSONData = JSON(data)
		//
		//                if let arr = booksJSONData.array {
		//                    for bookJSON in arr {
		//                        books.append(PLBook(json: bookJSON))
		//                    }
		//                }else {
		//                  return completion( Result.Failure(BookError.NoData) )
		//                }
		//
		//            case .Failure(let error):
		//                completion( Result.Failure(error) )
		//            }
		//        }
		let defaultConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: defaultConfiguration)
		
		if let url = NSURL(string: API.books) {
			(session.dataTaskWithURL(url) { (data, response, error) in
				
				var books: [PLBook] = []
				if let error = error {
					return completion( Result.Failure(error) )
				}
				guard let data = data else {
					return completion( Result.Failure(BookError.NoData) )
				}
				
				let booksJSONData = JSON(data:data)
				if let arr = booksJSONData.array {
					for bookJSON in arr {
						books.append( PLBook(json: bookJSON) )
					}
				} else {
					return completion( Result.Failure(BookError.NoData) )
				}
				
				completion( Result.Success(books) )
				}).resume()
		}
	}
	
	func addBook(book: PLBook, completion:() -> ()) {
		let parameters : [String:AnyObject] = [
			"author": book.author,
			"categories": book.categories,
			"title": book.title,
			"publisher": book.publisher
		]
		Alamofire.request(.POST, API.books,
			parameters: parameters,
			encoding: .JSON
			)
			.validate(statusCode: 200..<300)
			.response { (request, response, data, error) in
				debugPrint("Book created: \(data)")
		}
	}
	
	func getBook(path: String, completion:() -> ()) {
		let requestURL = API.server + path
		Alamofire.request(.GET, requestURL).responseJSON { response in
			
		}
	}
	
	func updateBook(lastCheckedOutBy: String,
		lastCheckedOut: String,
		path: String,
		completion:() -> ())
	{
		let requestURL = API.server + path
		let parameters : [String:AnyObject] = [
			"lastCheckedOutBy": lastCheckedOutBy,
			"lastCheckedOut" : lastCheckedOut
		]
		Alamofire.request(.PUT, requestURL, parameters: parameters, encoding: .JSON)
			.validate(statusCode: 200..<300)
			.response { (request, response, data, error) in
				
		}
	}
	
	func deleteBook(path: String, completion:() -> ()) {
		let requestURL = API.server + path
		Alamofire.request(.DELETE, requestURL)
			.validate(statusCode: 200..<300)
			.response{(request, response, data, error) in
				
		}
	}
	
	func deleteBooks(completion:() -> ()) {
		Alamofire.request(.DELETE, API.cleanBooks)
			.validate(statusCode: 200..<300)
			.response{(request, response, data, error) in
				
		}
	}
}