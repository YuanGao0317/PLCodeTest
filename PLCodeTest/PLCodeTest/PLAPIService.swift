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
typealias FetchDone = (PLResult<[PLBook]>) -> Void
typealias AddDone = (PLResult<PLBook>) -> Void
typealias DeleteDone = (Bool) -> Void
typealias UpdateDone = (Bool) -> Void

// MARK: - Protocol
protocol PLAPIService {
	func fetchBooks(_ completion: @escaping FetchDone)
	func addBook(_ book: PLBook, completion: @escaping AddDone)
	func updateBook(_ book: PLBook, completion: @escaping UpdateDone)
	func deleteBook(_ book: PLBook, completion: @escaping DeleteDone)
	func deleteBooks(_ completion: @escaping DeleteDone)
}


final class APIServiceController: PLAPIService {

	// MARK: - Properties
	private lazy var defaultSession: URLSession = {
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
					
					if let httpResponse = response as? HTTPURLResponse {
						guard httpResponse.statusCode == 200 else {
							return completion( PLResult.failure(PLNetworkError.badRequest))
						}
					}
					
					if let error = error {
						return completion( PLResult.failure(error) )
					}
					guard let data = data else {
						return completion( PLResult.failure(PLBookError.noData) )
					}
					
					var books: [PLBook] = []
					
					let booksJSONData = JSON(data:data)
					if let arr = booksJSONData.array {
						for bookJSON in arr {
							books.append( PLBook(json: bookJSON) )
						}
					} else {
						return completion( PLResult.failure(PLBookError.creationFailed) )
					}
					
					completion( PLResult.success(books) )
				}).resume()
			}
		})
	}
	
	// MARK: - Create a book
	func addBook(_ book: PLBook, completion: @escaping AddDone) {
		let url: URL = URL(string: API.books)!

		let postBody = ["title": book.title,
		                "author": book.author,
		                "publisher": book.publisher,
		                "categories": book.categories,
		                "lastCheckedOut": "",
		                "lastCheckedOutBy": ""
		                ]
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: [])
		request.timeoutInterval = 10
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let task = defaultSession.dataTask(with: request) {
			(data, response, error) in
			
			if let httpResponse = response as? HTTPURLResponse {
				guard httpResponse.statusCode < 300 else {
					return completion( PLResult.failure(PLNetworkError.badRequest))
				}
			}
			
			if let errorExist = error {
				return completion( PLResult.failure(errorExist) )
			}
			guard let data = data else {
				return completion( PLResult.failure(PLBookError.noData) )
			}
			
			let bookJSONData = JSON(data:data)
			let book = PLBook(json: bookJSONData)
			completion( PLResult.success(book) )
			
		}
		task.resume()
	}
	
	// MARK: - Update a book
	func updateBook(_ book: PLBook, completion: @escaping UpdateDone)
		{
			if let url = URL(string: API.books + String(describing: book.id!)) {

				let postBody = ["lastCheckedOut": book.lastCheckedOut,
				                "lastCheckedOutBy": book.lastCheckedOutBy]
				
				var request = URLRequest(url: url)
				request.httpMethod = "PUT"
				request.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: [])
				request.timeoutInterval = 10
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
				
				let task = defaultSession.dataTask(with: request) {
					(data, response, error) in
					
					if let httpResponse = response as? HTTPURLResponse {
						guard httpResponse.statusCode < 300 else {
							return completion( false )
						}
					}
					
					if let _ = error {
						return completion(false)
					}

					completion( true )
				}
				task.resume()
			}
		}
	
	// MARK: - Delete a book
	func deleteBook(_ book: PLBook, completion: @escaping DeleteDone) {
		if let url = URL(string: API.books + String(describing: book.id!)) {
			let queue = DispatchQueue.global(qos: .background)
			
			unowned let unownedSelf = self
			queue.async(execute: {
				
				var request = URLRequest(url: url)
				request.httpMethod = "DELETE"
				request.timeoutInterval = 10
				
				(unownedSelf.defaultSession.dataTask(with: request) {
					(data, response, error) in
					
					if let httpResponse = response as? HTTPURLResponse {
						guard httpResponse.statusCode < 300 else {
							return completion( false )
						}
					}
					
					if let _ = error {
						return completion(false)
					}
					
					completion(true)
				}).resume()
				
			})
		}
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
					
					if let httpResponse = response as? HTTPURLResponse {
						guard httpResponse.statusCode < 300 else {
							return completion( false )
						}
					}
					
					if let _ = error {
						return completion(false)
					}
					completion(true)
				}).resume()
			}
		})
	}
	
}
