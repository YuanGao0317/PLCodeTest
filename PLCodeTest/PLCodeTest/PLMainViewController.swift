//
//  ViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLMainViewController: UIViewController {
	// MARK: - Properties
	@IBOutlet weak var tableView: UITableView!
	lazy var apiService = APIServiceController()
	
	var books: [PLBook] = [] {
		didSet {
			DispatchQueue.main.async { [unowned me = self] in
				me.tableView.reloadData()
			}
		}
	}
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadData()
	}
	
	// MARK: - Event Responses
  @IBAction func onDeleteAllBtnClick(_ sender: UIBarButtonItem) {
    apiService.deleteBooks { (success) in
			if success {
				self.books = []
			} else {
				DispatchQueue.main.async {
					MessageController.snackMessage("Failed to delete all books.")
				}
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
		
		if let addBookVC = destination as? PLAddBookViewController {
			if let identifier = segue.identifier {
				switch identifier {
				case Constants.addBookSegue:
					addBookVC.apiService = APIServiceController()
				default: debugPrint("no indentifier")
				}
			}
		}
	}
	
	// MARK: - Private
	private func loadData(){
		apiService.fetchBooks { (result) -> Void in
			do {
				let books = try result.resolve()
				self.books = books
			} catch {
				debugPrint(error)
			}
		}
	}
}

