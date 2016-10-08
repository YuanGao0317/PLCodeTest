//
//  ViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLMainViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	lazy var apiService = APIServiceController()
	
	var books: [PLBook] = [] {
		didSet {
			DispatchQueue.main.async { [unowned me = self] in
				me.tableView.reloadData()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loadData()
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

