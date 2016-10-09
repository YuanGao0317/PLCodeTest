//
//  PLAPIService.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//
//

import SwiftyJSON

// MARK: - Callback Type
typealias FetchDone = (Result<[PLBook]>) -> Void
typealias AddDone = (Result<PLBook>) -> Void
typealias DeleteDone = (Bool) -> Void

// MARK: - Protocol
protocol PLAPIService {
	func fetchBooks(_ completion: @escaping FetchDone)
	func addBook(_ book: PLBook, completion: @escaping AddDone)
	//	func getBook(_ path: String, completion:() -> ())
	//	func updateBook(_ lastCheckedOutBy: String,
	//		lastCheckedOut: String,
	//		path: String,
	//		completion:() -> ()
	//	)
	func deleteBook(_ path: String, completion: @escaping DeleteDone)
	func deleteBooks(_ completion: @escaping DeleteDone)
}


final class APIServiceController: PLAPIService {
	
	// MARK: - Properties
	lazy var defaultSession: URLSession = {
		let defaultConfiguration = URLSessionConfiguration.default
		let session = URLSession(configuration: defaultConfiguration)
		return session
	}()
	
	// MARK: - Fetch all books
	func fetchBooks(_ completion: @escaping FetchDone) {
		let queue = DispatchQueue.global(qos: .background)
		
		unowned let unownedSelf = self
		queue.async(execute: {
			if let url = URL(string: API.books) {
				
				(unownedSelf.defaultSession.dataTask(with: url) {
					(data, response, error) in
					
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
	
	// MARK: - Create a book
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
		request.timeoutInterval = 10
		
		let task = defaultSession.dataTask(with: request) {
			(data, response, error) in
			
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
	
	// MARK: - Delete a book
	func deleteBook(_ path: String, completion: @escaping DeleteDone) {
		let url = API.server + path
		
		let queue = DispatchQueue.global(qos: .background)
		
		unowned let unownedSelf = self
		queue.async(execute: {
			if let url: URL = URL(string: url) {
				var request = URLRequest(url: url)
				request.httpMethod = "DELETE"
				request.timeoutInterval = 10
				
				(unownedSelf.defaultSession.dataTask(with: request) {
					(data, response, error) in
					if let _ = error {
						return completion(false)
					}
					
					completion(true)
				}).resume()
			}
		})

		
	}
	
	// MARK: - Delete all books
	func deleteBooks(_ completion: @escaping DeleteDone) {
		let queue = DispatchQueue.global(qos: .background)
		
		unowned let unownedSelf = self
		queue.async(execute: {
			if let url: URL = URL(string: API.cleanBooks) {
				var request = URLRequest(url: url)
				request.httpMethod = "DELETE"
				request.timeoutInterval = 10
				
				(unownedSelf.defaultSession.dataTask(with: request) {
					(data, response, error) in
					if let _ = error {
						return completion(false)
					}
					completion(true)
				}).resume()
			}
		})
	}
	
}
