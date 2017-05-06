//
//  AppDelegate.swift
//  YYZB
//
//  Created by unicorn on 17/4/6.
//  Copyright © 2017年 unicorn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor=UIColor.orange
        
        return true
    }

}
