//
//  PLMainViewController+TableViewDataSource.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource
extension PLMainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let book = books[(indexPath as NSIndexPath).row]
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
    
    cell.textLabel?.text = book.title
    cell.detailTextLabel?.text = book.author
    
    cell.backgroundColor = UIColor.clear
    
    return cell
  }
}
