//
//  PLAPIService.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
//
//import Alamofire
import SwiftyJSON
//
//
import Foundation

typealias Done = (Result<[PLBook]>) -> Void
//
protocol PLAPIService {
	func fetchBooks(_ completion: @escaping Done)
//	func addBook(_ book: PLBook, completion:() -> ())
//	func getBook(_ path: String, completion:() -> ())
//	func updateBook(_ lastCheckedOutBy: String,
//		lastCheckedOut: String,
//		path: String,
//		completion:() -> ()
//	)
//	func deleteBook(_ path: String, completion:() -> ())
//	func deleteBooks(_ completion:() -> ())
}
//
final class APIServiceController: PLAPIService {
//
//
	lazy var defaultSession: URLSession = {
		let defaultConfiguration = URLSessionConfiguration.default
		let session = URLSession(configuration: defaultConfiguration)
		return session
	}()
	
	func fetchBooks(_ completion: @escaping Done) {
//		Alamofire.request(.GET, API.books).responseJSON { (request, response, result) in
//			
//			switch result {
//			case .Success(let data):
//				var books: [PLBook] = []
//				let booksJSONData = JSON(data)
//				
//				if let arr = booksJSONData.array {
//					
//					for bookJSON in arr {
//						books.append(PLBook(json: bookJSON))
//					}
//					
//					completion( Result.Success(books) )
//				}else {
//					completion( Result.Failure(BookError.NoData) )
//				}
//				
//			case .Failure(let error):
//				completion( Result.Failure(error.1) )
//			}
//		}
		let queue = DispatchQueue.global(qos: .background)
		
		
		queue.async(execute: {
			if let url = URL(string: API.books) {
				
				unowned let unownedSelf = self
				(unownedSelf.defaultSession.dataTask(with: url) { (data, response, error) in

					var books: [PLBook] = []
					
					if let error = error {
						return completion( Result.failure(error) )
					}
					guard let data = data else {
						return completion( Result.failure(BookError.noData) )
					}
					
					let booksJSONData = JSON(data:data)
					if let arr = booksJSONData.array {
						for bookJSON in arr {
							books.append( PLBook(json: bookJSON) )
						}
					} else {
						return completion( Result.failure(BookError.noData) )
					}
					
					completion( Result.success(books) )
					}).resume()
			}
		})
	}
//
//	func addBook(_ book: PLBook, completion:() -> ()) {
//		let parameters : [String:AnyObject] = [
//			"author": book.author as AnyObject,
//			"categories": book.categories as AnyObject,
//			"title": book.title as AnyObject,
//			"publisher": book.publisher as AnyObject
//		]
//		Alamofire.request(.POST, API.books,
//			parameters: parameters,
//			encoding: .JSON
//			)
//			.validate(statusCode: 200..<300)
//			.response { (request, response, data, error) in
//				debugPrint("Book created: \(data)")
//		}
//	}
//	
//	func getBook(_ path: String, completion:() -> ()) {
//		let requestURL = API.server + path
//		Alamofire.request(.GET, requestURL).responseJSON { response in
//			
//		}
//	}
//	
//	func updateBook(_ lastCheckedOutBy: String,
//		lastCheckedOut: String,
//		path: String,
//		completion:() -> ())
//	{
//		let requestURL = API.server + path
//		let parameters : [String:AnyObject] = [
//			"lastCheckedOutBy": lastCheckedOutBy as AnyObject,
//			"lastCheckedOut" : lastCheckedOut as AnyObject
//		]
//		Alamofire.request(.PUT, requestURL, parameters: parameters, encoding: .JSON)
//			.validate(statusCode: 200..<300)
//			.response { (request, response, data, error) in
//				
//		}
//	}
//	
//	func deleteBook(_ path: String, completion:() -> ()) {
//		let requestURL = API.server + path
//		Alamofire.request(.DELETE, requestURL)
//			.validate(statusCode: 200..<300)
//			.response{(request, response, data, error) in
//				
//		}
//	}
//	
//	func deleteBooks(_ completion:() -> ()) {
//		Alamofire.request(.DELETE, API.cleanBooks)
//			.validate(statusCode: 200..<300)
//			.response{(request, response, data, error) in
//				
//		}
//	}

}
