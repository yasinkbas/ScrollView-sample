//
//  AppDelegate.swift
//  scrollView-sample
//
//  Created by Yasin Akbaş on 19.10.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

