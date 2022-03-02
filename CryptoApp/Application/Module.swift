//
//  Module.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

public struct ModuleDependencies {
    let apiDataTransferService: DataTransferService
    public init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
}

public struct Module {
    private let diContainer: DIContainer
    public init(dependencies: ModuleDependencies) {
        self.diContainer = DIContainer(dependencies: dependencies)
    }
    
    public func makeRootViewController() -> UIViewController {
        let coordinator = diContainer.makeFlowCoordinator()
        coordinator.start()
        return coordinator.mainViewController ?? UIViewController()
        
    }
}



