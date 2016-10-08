//
//  PLAddBookViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit
import TTGSnackbar

class PLAddBookViewController: UIViewController {
  
  @IBOutlet weak var formView: PLNewBookFormView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    formView.raisedbutton.addTarget(self, action: #selector(PLAddBookViewController.buttonTapped), for: .touchUpInside)
  }
  
  @IBAction func onDoneBtnClick(_ sender: UIBarButtonItem) {
    view.endEditing(true)
    
    
    presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
  func buttonTapped() {
    snackMessage("hello")
    
  }
  
}

extension PLAddBookViewController {
  func snackMessage(_ message: String) {
    let snackbar = TTGSnackbar.init(message: message, duration: .short)
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
  }
}
