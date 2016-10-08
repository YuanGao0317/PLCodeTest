//
//  PLAPIService.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
//

import SwiftyJSON


typealias FetchDone = (Result<[PLBook]>) -> Void
typealias AddDone = (Result<PLBook>) -> Void


protocol PLAPIService {
	func fetchBooks(_ completion: @escaping FetchDone)
	func addBook(_ book: PLBook, completion: @escaping AddDone)
	//	func getBook(_ path: String, completion:() -> ())
	//	func updateBook(_ lastCheckedOutBy: String,
	//		lastCheckedOut: String,
	//		path: String,
	//		completion:() -> ()
	//	)
	//	func deleteBook(_ path: String, completion:() -> ())
	//	func deleteBooks(_ completion:() -> ())
}


final class APIServiceController: PLAPIService {

	lazy var defaultSession: URLSession = {
		let defaultConfiguration = URLSessionConfiguration.default
		let session = URLSession(configuration: defaultConfiguration)
		return session
	}()

	
	func fetchBooks(_ completion: @escaping FetchDone) {
		let queue = DispatchQueue.global(qos: .background)
		
		unowned let unownedSelf = self
		queue.async(execute: {
			if let url = URL(string: API.books) {
				
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
						return completion( Result.failure(BookError.creationFailed) )
					}
					
					completion( Result.success(books) )
				}).resume()
			}
		})
	}

	func addBook(_ book: PLBook, completion: @escaping AddDone) {
		let url: URL = URL(string: API.books)!
	
		let stringPost="title=" + book.title +
									"&author=" + book.author +
									"&publisher=" + book.publisher +
									"&categories=" + book.categories
		
		let data = stringPost.data(using: String.Encoding.utf8)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.timeoutInterval = 15
		
		let task = defaultSession.dataTask(with: request) { (data, response, error) in
			if let error = error {
				return completion( Result.failure(error) )
			}
			guard let data = data else {
				return completion( Result.failure(BookError.noData) )
			}
			
			let bookJSONData = JSON(data:data)
			let book = PLBook(json: bookJSONData)
			completion( Result.success(book) )

		}
		task.resume()
	}
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
