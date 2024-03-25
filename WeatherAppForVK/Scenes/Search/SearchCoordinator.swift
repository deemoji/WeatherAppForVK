//
//  SearchCoordinator.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 25.03.2024.
//

import Foundation
import UIKit
import Combine


final class SearchCoordinator: BaseCoordinator {
    
    private let services: SearchServiceProvider
    private var bag = Set<AnyCancellable>()
    
    init(services: SearchServiceProvider) {
        self.services = services
    }
    override func start() {
        let viewController = SearchViewController()
        let viewModel = SearchViewModel(services.makeSearchService())
        viewController.viewModel = viewModel
        viewModel.selectedCity.sink { [weak self] in
            self?.toDetails($0)
        }.store(in: &bag)
        viewModel.viewWillDisappear.sink { [unowned self] in
            parent?.didFinish(coordinator: self)
        }.store(in: &bag)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func toDetails(_ city: String) {
        let coordinator = DetailsCoordinator(provider: QueryWeatherServiceProvider(city))
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
