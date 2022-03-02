//
//  MainFlowCoordinator.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

protocol FlowCoordinatorDependencies {
    func makeHomeViewController() -> UIViewController
}

class MainFlowCoordinator {
    let dependencies: FlowCoordinatorDependencies
    var mainViewController: UIViewController?
    
    init(dependencies:FlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }

    func start() {
        mainViewController = dependencies.makeHomeViewController()
    }
}


