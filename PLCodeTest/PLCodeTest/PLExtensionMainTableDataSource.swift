//
//  PLMainViewController+TableViewDataSource.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

extension PLMainViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellReuseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "Book Title"
        cell.detailTextLabel?.text = "Book Author"
        
        return cell
    }
}