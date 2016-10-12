//
//  ViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLMainViewController: UIViewController, MessageController {
	
	// MARK: - Properties
	@IBOutlet weak var tableView: UITableView!
	lazy var apiService: PLAPIService = APIServiceController()
	
	var books: [PLBook] = [] {
		didSet {
			DispatchQueue.main.async { [unowned me = self] in
				me.tableView.reloadSections([0], with: .fade)
			}
		}
	}
	
	// MARK: - Life Cycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		loadData()
	}
	
	// MARK: - Event Responses
  @IBAction func onDeleteAllBtnClick(_ sender: UIBarButtonItem) {
		guard self.books.count > 0 else {
			self.snackMessage("There is no book.")
			return
		}
		
		showWarningMessage()
  }
	
	func loadData(){
		apiService.fetchBooks { (result) -> Void in
			do {
				let books = try result.resolve()
				self.books = books
			} catch {
				self.snackMessage("Failed to fetch books.")
			}
		}
	}
	
	@IBAction func onAddBtnClick(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: Constants.addBookSegue, sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		var destination = segue.destination
		if let navCon = destination as? UINavigationController {
			destination = navCon.visibleViewController!
		}
		
		
		if let identifier = segue.identifier {
			switch identifier {
			case Constants.addBookSegue:
				if let addBookVC = destination as? PLAddBookViewController {
					addBookVC.apiService = APIServiceController()
				}
			case Constants.showBookSegue:
				if let bookDetailVC = destination as? PLBookDetailViewController,
						let indexPath = sender as? IndexPath
				{
					bookDetailVC.book = books[indexPath.row]
					bookDetailVC.apiService = APIServiceController()
				}
			default: break
			}
		}
	}
	
	
	// MARK: - Private
	private func deleteAllBooks() {
		apiService.deleteBooks { (success) in
			if success {
				self.books = []
				self.snackMessage("All books are deleted!")
			} else {
				self.snackMessage("Failed to delete all books.")
			}
		}
	}
	
	private func showWarningMessage() {
		let alertController = UIAlertController(title: "Warning",
		                                        message: "Are you sure you want to delete all books?",
		                                        preferredStyle: .alert)
		
		unowned let unownedSelf = self
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
			(action) in
			unownedSelf.deleteAllBooks()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alertController.addAction(deleteAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
	}
}


