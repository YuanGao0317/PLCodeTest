//
//  PLBookDetailViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLBookDetailViewController: UIViewController {
  
  var book: PLBook?
  
  @IBOutlet weak var bookDetailView: PLBookDetailView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let _ = book {
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
