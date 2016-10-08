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
  var apiService: PLAPIService?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFormView()
  }
  
  @IBAction func onDoneBtnClick(_ sender: UIBarButtonItem) {
    view.endEditing(true)
    
    if formView.anyTextFieldNotEmpty() {
      showWarningMessage()
    } else {
      presentingViewController?.dismiss(animated: true, completion: nil)
    }
  }
  
  func onSubmitClick() {
    let title = formView.titleField.text ?? ""
    let author = formView.authorField.text ?? ""
    let publisher = formView.publisherField.text ?? ""
    let categories = formView.categoriesField.text ?? ""
    do {
      let book = try PLBook(author: author,
                            categories: categories,
                            lastCheckedOut: "",
                            lastCheckedOutBy: "",
                            publisher: publisher,
                            title: title,
                            url: ""
      )
      
      apiService?.addBook(book, completion: {
        
      })
    } catch ValidationError.isEmpty {
      snackMessage("Title and Author cannot be empty.")
    } catch {
      snackMessage("Unrecognized Error.")
    }
  }
  
  private func setupFormView() {
    formView.raisedbutton.addTarget(self,
                                    action: #selector(PLAddBookViewController.onSubmitClick),
                                    for: .touchUpInside
    )
  }
  
}

private extension PLAddBookViewController {
  func snackMessage(_ message: String) {
    let snackbar = TTGSnackbar.init(message: message, duration: .short)
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
  }
  
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
