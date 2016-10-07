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
	var books: [PLBook] = [] { didSet { tableView.reloadData() } }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	@IBAction func onAddBtnClick(sender: UIBarButtonItem) {
		
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

