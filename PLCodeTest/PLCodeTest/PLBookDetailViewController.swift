//
//  PLBookDetailViewController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit
import SCLAlertView
import Material

class PLBookDetailViewController: UIViewController, MessageController {
  // MARK: - Properties
  var book: PLBook!
  var apiService: PLAPIService!
  @IBOutlet weak var bookDetailView: PLBookDetailView!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupDetailView()
  }
  
  // MARK: - Event Responses
  func onCheckoutClick() {
    showAlertView()
  }
  
  @IBAction func onShareBtnClick(_ sender: UIBarButtonItem) {
    let shareContent = "Check out this book '\(book.title)' using Prolific Library"
    let itemsToShare = [shareContent]
    let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
    present(activityVC, animated: true, completion: nil)
  }
  
  
  
  
  // MARK: - Private
  private func setupDetailView() {
    let formattedDate = PLFormatter.formattedDate(from: book.lastCheckedOut)
    
    let lastCheckedOut = PLFormatter.formattedLastCheckedOut(fromLastCheckedOutBy: book.lastCheckedOutBy, andLastCheckedOut: formattedDate)
    
    bookDetailView.setFormContent(
      title: book.title,
      author: book.author,
      publisher: book.publisher,
      categories: book.categories,
      lastCheckedOut: lastCheckedOut
    )
    
    bookDetailView.checkoutBtn.addTarget(
      self,
      action: #selector(PLBookDetailViewController.onCheckoutClick),
      for: .touchUpInside
    )
  }
  
  private func showAlertView() {
    let alert = SCLAlertView()
    let checkoutBy = alert.addTextField("Enter your name")
    alert.addButton("Checkout") { [unowned that = self] in
      
      that.book.lastCheckedOut = PLFormatter.formattedCurrentDate()
      that.book.lastCheckedOutBy = checkoutBy.text!
      that.apiService.updateBook(that.book) { (success) in
        if success {
          self.snackMessage("Updated the book successfully.")
          DispatchQueue.main.async {
            let _ = self.navigationController?.popViewController(animated: true)
          }
        } else {
          self.snackMessage("Failed to update the book.")
        }
      }
    }
    alert.showSuccess("Edit View", subTitle: "Please enter your name to checkout:")
    //    alert.showCustom("Edit View", subTitle: "Please enter your name to checkout:", color: .cyan, icon: Icon.edit!, closeButtonTitle: nil, duration: 0, colorStyle: 0x1976D2, colorTextButton: 0x1976D2, circleIconImage: nil, animationStyle: .topToBottom)
  }
  
}


