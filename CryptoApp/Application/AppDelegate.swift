//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let config = ApiDataNetworkConfig(baseURL: URL(string: "https://api.coincap.io/v2")!)
        let apiDataNetwork = DefaultNetworkService(config: config)
        let apiDataTransferService = DefaultDataTransferService(with: apiDataNetwork)
        
        let dependencies = ModuleDependencies(apiDataTransferService: apiDataTransferService)
        let vc = Module(dependencies: dependencies).makeRootViewController()
        let navigationViewController = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }


}

