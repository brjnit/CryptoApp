//
//  DIContainer.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 19/02/22.
//

import UIKit

struct DIContainer{
    private let dependencies: ModuleDependencies
    init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }
    
    func makeFlowCoordinator() -> MainFlowCoordinator {
        return MainFlowCoordinator(dependencies: self)
    }
}

extension DIContainer: FlowCoordinatorDependencies {
    func makeHomeViewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "HomeScreen", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return UIViewController() }
        let repository = DefaultMarketRepository(service: dependencies.apiDataTransferService)
        let usecase = DefaultMarketUsecase(repository: repository)
        vc.viewModel = CryptoViewModel(usecase: usecase)
        return vc
    }
    
}
