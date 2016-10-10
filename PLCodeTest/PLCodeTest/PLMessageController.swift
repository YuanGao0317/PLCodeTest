//
//  PLMessageController.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/8/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import TTGSnackbar

//final class MessageController {
//  static func snackMessage(_ message: String) {
//    DispatchQueue.main.async {
//      let snackbar = TTGSnackbar.init(message: message, duration: .short)
//      snackbar.animationType = .slideFromTopBackToTop
//      snackbar.show()
//    }
//  }
//}

protocol MessageController {
  func snackMessage(_ message: String)
}

extension MessageController {
  func snackMessage(_ message: String) {
    DispatchQueue.main.async {
      let snackbar = TTGSnackbar.init(message: message, duration: .short)
      snackbar.animationType = .slideFromTopBackToTop
      snackbar.show()
    }
  }
}
