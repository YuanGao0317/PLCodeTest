//
//  AppDelegate.swift
//  PLCodeTest
//
//  Created by GaoYuan on 10/7/16.
//  Copyright © 2016 YuanGao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    globalAppearence()
    
    return true
  }
  
  
  private func globalAppearence() {
    UINavigationBar.appearance().barTintColor = PLColor.cleanRed
    UIBarButtonItem.appearance().tintColor = PLColor.white
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : PLColor.white]
  }
  
}

