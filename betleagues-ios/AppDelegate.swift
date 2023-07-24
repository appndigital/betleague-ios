//
//  AppDelegate.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        let _window = UIWindow(frame: UIScreen.main.bounds)
        
        window = _window
        coordinator = Coordinator(window: _window)
        
        coordinator.start()
        
        return true
    }
}

