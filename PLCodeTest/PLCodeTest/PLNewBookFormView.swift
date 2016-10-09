//
//  PLNewBookFormView.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit
import Material

// MARK: - Constants
private struct FormLayout {
  struct RaisedButton {
    static let width: CGFloat = 150
    static let height: CGFloat = 36
  }
  
  struct TextField {
    static let height: CGFloat = 60.0
    static let marginLeft: CGFloat = 40.0
    static let marginRight: CGFloat = 40.0
  }
}


@IBDesignable class PLNewBookFormView: UIView {
  
  // MARK: - Properties
  private weak var view: UIView!
  weak var titleField: TextField!
  weak var authorField: TextField!
  weak var publisherField: TextField!
  weak var categoriesField: TextField!
  var raisedbutton: RaisedButton!
  
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    formViewSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    formViewSetup()
  }
  
  // MARK: - Methods
  func anyTextFieldNotEmpty() -> Bool {
    return (titleField.text != "" ||
            authorField.text != "" ||
            publisherField.text != "" ||
            categoriesField.text != "")
  }
  
  
  
  
  // MARK: - Private Functions
  private func formViewSetup() {
    xibSetup()
    prepareForForm()
    addGestureForDismissKeyboard()
  }
  
  private func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    view.backgroundColor = UIColor.white
    addSubview(view)
  }
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: Constants.PLNewBookFormView, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  private func prepareForForm() {
    prepareForTitleField()
    prepareForAuthorField()
    prepareForPublisherField()
    prepareForCategoriesField()
    prepareRaisedButton()
  }
  
  
  private func prepareForTitleField() {
    titleField = TextField()
    titleField.placeholder = "Book Title"
    titleField.textAlignment = .center
    titleField.clearButtonMode = .whileEditing
    view.layout(titleField)
      .top(FormLayout.TextField.height)
      .horizontally(left: FormLayout.TextField.marginLeft, right: FormLayout.TextField.marginRight)
  }
  
  private func prepareForAuthorField() {
    authorField = TextField()
    authorField.placeholder = "Author"
    authorField.textAlignment = .center
    authorField.clearButtonMode = .whileEditing
    view.layout(authorField)
      .top(FormLayout.TextField.height * 2)
      .horizontally(left: FormLayout.TextField.marginLeft, right: FormLayout.TextField.marginRight)
  }
  
  private func prepareForPublisherField() {
    publisherField = TextField()
    publisherField.placeholder = "Publisher"
    publisherField.textAlignment = .center
    publisherField.clearButtonMode = .whileEditing
    view.layout(publisherField)
      .top(FormLayout.TextField.height * 3)
      .horizontally(left: FormLayout.TextField.marginLeft, right: FormLayout.TextField.marginRight)
  }
  
  private func prepareForCategoriesField() {
    categoriesField = TextField()
    categoriesField.placeholder = "Categories"
    categoriesField.textAlignment = .center
    categoriesField.clearButtonMode = .whileEditing
    view.layout(categoriesField)
      .top(FormLayout.TextField.height * 4)
      .horizontally(left: FormLayout.TextField.marginLeft, right: FormLayout.TextField.marginRight)
  }
  
  private func prepareRaisedButton() {
    raisedbutton = RaisedButton(title: "Submit", titleColor: Color.white)
    raisedbutton.pulseColor = Color.white
    raisedbutton.backgroundColor = PLColor.cleanRedColor
    
    view.layout(raisedbutton)
      .width(FormLayout.RaisedButton.width)
      .height(FormLayout.RaisedButton.height)
      .top(FormLayout.TextField.height * 5)
      .centerHorizontally()
  }
  
  private func addGestureForDismissKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
}

