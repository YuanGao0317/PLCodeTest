//
//  PLAddBookViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

class PLAddBookViewController: UIViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
      activityIndicator.startAnimating()
      apiService?.addBook(book) { (result) in
        do {
          let _ = try result.resolve()
          DispatchQueue.main.async { [unowned that = self] in
            that.activityIndicator.stopAnimating()
            MessageController.snackMessage("Book is created!")
            that.resetFormTextFields()
          }
        } catch {
          DispatchQueue.main.async { [unowned that = self] in
            that.activityIndicator.stopAnimating()
            MessageController.snackMessage("Failed to create book.")
          }
        }
      }
    } catch ValidationError.isEmpty {
      MessageController.snackMessage("Title and Author cannot be empty.")
    } catch {
      MessageController.snackMessage("Unrecognized Error.")
    }
  }
  
  private func setupFormView() {
    formView.raisedbutton.addTarget(self,
                                    action: #selector(PLAddBookViewController.onSubmitClick),
                                    for: .touchUpInside
    )
  }
  
  private func resetFormTextFields() {
    view.endEditing(true)
    formView.resetTextFields()
  }
  
}


