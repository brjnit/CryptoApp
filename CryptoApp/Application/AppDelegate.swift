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
        let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return false }
        
        let repository = MerketService(service: ClientAPI())
        let usecase = DefaultMarketUsecase(repository: repository)
        vc.viewModel = CryptoViewModel(usecase: usecase)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }


}

