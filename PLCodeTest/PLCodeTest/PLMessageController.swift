//
//  PLMessageController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import TTGSnackbar

final class MessageController {
  class func snackMessage(_ message: String) {
    let snackbar = TTGSnackbar.init(message: message, duration: .middle)
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.show()
  }
}
