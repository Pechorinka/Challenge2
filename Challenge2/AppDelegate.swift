//
//  AppDelegate.swift
//  Challenge2
//
//  Created by Tatyana Sidoryuk on 28.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        window?.rootViewController = AppNavigationController(rootViewController: FirstViewController())
        
        window?.makeKeyAndVisible()
        
        return true


    }
}

class AppNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.setNavigationBarHidden(true, animated: false)
    }
}
