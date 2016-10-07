//
//  ViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLMainViewController: UIViewController {
	
	lazy var apiService = APIServiceController()
	var books: [PLBook] = [] {
		didSet {
			debugPrint(self.books)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		apiService.fetchBooks { (result) -> Void in
			do {
				let books = try result.resolve()
				self.books = books
			} catch {
				debugPrint(error)
			}
		}
	}
	
    @IBAction func onAddBtnClick(sender: UIBarButtonItem) {
    }
    
	
	
}

