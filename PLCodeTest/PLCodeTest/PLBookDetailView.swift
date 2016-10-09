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

  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    formViewSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    formViewSetup()
  }
  
  private func formViewSetup() {
    xibSetup()
  }
  
  private func xibSetup() {
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
    view.backgroundColor = UIColor.purple
    addSubview(view)
  }
  
  private func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: Constants.PLNewBookFormView, bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
}
