//
//  DetailsCoordinator.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 25.03.2024.
//

import Foundation
import UIKit

final class DetailsCoordinator: BaseCoordinator {
    
    private let provider: WeatherServiceProvider
    
    init(provider: WeatherServiceProvider) {
        self.provider = provider
    }
    override func start() {
        let homeViewController = HomeViewController()
        homeViewController.viewModel = HomeViewModel(service: provider.makeWeatherService())
        homeViewController.title = "Details"
        homeViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClose))
        homeViewController.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "VKBlue")
        let modalNC = UINavigationController(rootViewController: homeViewController)
        navigationController.present(modalNC, animated: true)
    }
    @objc private func onClose() {
        navigationController.dismiss(animated: true)
        parent?.didFinish(coordinator: self)
    }
    
}
