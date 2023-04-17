//
//  AppDelegate.swift
//  DutchRijksMuseumApiClient
//
//  Created by Alejandro Fernandez Ruiz on 17/4/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationCon = UINavigationController.init()
    
    let initialVC = CollectionViewController().configureViewController()

    navigationCon.pushViewController(initialVC, animated: true)
    window!.rootViewController = navigationCon
    window!.makeKeyAndVisible()
    return true
  }



}

