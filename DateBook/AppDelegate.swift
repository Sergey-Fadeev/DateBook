//
//  AppDelegate.swift
//  DateBook
//
//  Created by Sergey on 13.10.2021.
//

import UIKit

var tasksSingletone = TaskModel()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

