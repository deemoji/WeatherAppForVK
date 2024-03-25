//
//  HomeCoordinator.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    
    private let provider: WeatherServiceProvider
    
    init(provider: WeatherServiceProvider) {
        self.provider = provider
    }
    
    override func start() {
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        homeViewController.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "VKBlue")
        let vm = HomeViewModel(service: provider.makeWeatherService())
        homeViewController.viewModel = vm
        navigationController.pushViewController(homeViewController, animated: true)
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        navigationController.title = "Home"
        navigationController.navigationBar.tintColor = UIColor(named: "BackgroundColor")
        navigationController.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") as Any]
        
    }
    
    @objc func searchButtonTapped() {
        toSearch()
    }
    
    func toSearch() {
        let coordinator = SearchCoordinator(services: MKSearchServiceProvider())
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
