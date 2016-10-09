//
//  PLExtensionAddBookViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit


extension PLAddBookViewController {
  func showWarningMessage() {
    let alertController = UIAlertController(title: "Warning",
                                            message: "Are you sure you want to leave this page?",
                                            preferredStyle: .alert)
    
    unowned let unownedSelf = self
    let okAction = UIAlertAction(title: "Close", style: .destructive) { (action) in
      unownedSelf.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
}
