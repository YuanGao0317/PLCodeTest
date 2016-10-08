//
//  PLNewBookFormView.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit
import Material

@IBDesignable class PLNewBookFormView: UIView {

  // Our custom view from the XIB file
  private var view: UIView!
  var titleField: TextField!
  var authorField: TextField!
  var publisherField: TextField!
  var categoriesField: TextField!
  
  private let textFieldHeight: CGFloat = 60.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    xibSetup()
  }
  
  
  
  
  
  
  
  private func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    
    // Make the view stretch with containing view
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    
    addSubview(view)
    view.backgroundColor = Color.grey.lighten3
    
    prepareForAllTextField()
    addGestureForDismissKeyboard()
    
  }
  
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: Constants.PLNewBookFormView, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  private func prepareForAllTextField() {
    prepareForTitleField()
    prepareForAuthorField()
    prepareForPublisherField()
    prepareForCategoriesField()
  }
  
  
  private func prepareForTitleField() {
    titleField = TextField()
    titleField.placeholder = "Book Title"
    titleField.textAlignment = .center
    titleField.clearButtonMode = .whileEditing
    view.layout(titleField).top(textFieldHeight).horizontally(left: 40, right: 40)
  }
  
  private func prepareForAuthorField() {
    authorField = TextField()
    authorField.placeholder = "Author"
    authorField.textAlignment = .center
    authorField.clearButtonMode = .whileEditing
    view.layout(authorField).top(textFieldHeight * 2).horizontally(left: 40, right: 40)
  }
  
  private func prepareForPublisherField() {
    publisherField = TextField()
    publisherField.placeholder = "Publisher"
    publisherField.textAlignment = .center
    publisherField.clearButtonMode = .whileEditing
    view.layout(publisherField).top(textFieldHeight * 3).horizontally(left: 40, right: 40)
  }
  
  private func prepareForCategoriesField() {
    categoriesField = TextField()
    categoriesField.placeholder = "Categories"
    categoriesField.textAlignment = .center
    categoriesField.clearButtonMode = .whileEditing
    view.layout(categoriesField).top(textFieldHeight * 4).horizontally(left: 40, right: 40)
  }
  
  private func addGestureForDismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
}

