//
//  PLAddBookViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLAddBookViewController: UIViewController {
  
  @IBOutlet weak var formView: PLNewBookFormView!
  
  @IBAction func onDoneBtnClick(_ sender: UIBarButtonItem) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
}
