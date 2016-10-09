//
//  PLBookDetailView.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/9/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

@IBDesignable class PLBookDetailView: UIView {

  // MARK: - Properties
  private weak var view: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var publisherLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!
  @IBOutlet weak var lastCheckedOutLabel: UILabel!

  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    formViewSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    formViewSetup()
  }
  
  func setFormContent(title: String,
                      author: String,
                      publisher: String,
                      categories: String,
                      lastCheckedOut: String)
  {
    titleLabel.text = title
    authorLabel.text = author
    publisherLabel.text = publisher
    categoriesLabel.text = categories
    lastCheckedOutLabel.text = lastCheckedOut
  }
  
  func formatLastCheckedOut(with lastCheckedOut: String, and lastCheckedOutBy: String) -> String {
    
    return ""
  }
  
  private func formViewSetup() {
    xibSetup()
  }
  
  private func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    view.backgroundColor = UIColor.clear
    addSubview(view)
  }
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: Constants.PLBookDetailView, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
}
