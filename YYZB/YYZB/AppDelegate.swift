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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UITabBar.appearance().tintColor=UIColor.orangeColor()
        
        return true
    }

}