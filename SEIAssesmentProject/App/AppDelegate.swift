//
//  AppDelegate.swift
//  SEIAssesmentProject
//
//  Created by Roger Jones Work  on 7/28/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let handler = NavigationHandler()
        window?.rootViewController = MainTabBarController(handler: handler)
        window?.makeKeyAndVisible()
        return true
    }
}

