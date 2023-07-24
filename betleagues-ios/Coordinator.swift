//
//  Coordinator.swift
//  betleagues-ios
//
//  Created by Didier Nizard on 24/07/2023.
//

import UIKit

class Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
    }
    
    func start() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryColor
        
        let titleAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = titleAttribute

        rootViewController.navigationBar.standardAppearance = appearance
        rootViewController.navigationBar.scrollEdgeAppearance = appearance
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        window.rootViewController = rootViewController
        
        let mainVC = MainViewController()
        
        rootViewController.pushViewController(mainVC, animated: false)
        window.makeKeyAndVisible()
    }
    
}
