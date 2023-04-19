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
  
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let appWindow = window else {return false}
    
    let navigationCon = UINavigationController.init()
    
    let initialVC = CollectionViewController().configureViewController(appService: AppServices())
    
    navigationCon.pushViewController(initialVC, animated: true)
    appWindow.rootViewController = navigationCon
    appWindow.makeKeyAndVisible()
    
    let navigationBarAppearance = UINavigationBarAppearance()
    navigationBarAppearance.configureWithOpaqueBackground()
    navigationBarAppearance.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor.orange
    ]
    navigationBarAppearance.backgroundColor = UIColor.black
    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    
    return true
  }
}
