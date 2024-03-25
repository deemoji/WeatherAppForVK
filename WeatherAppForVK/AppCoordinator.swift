//
//  AppCoordinator.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let weatherProvider: WeatherServiceProvider = CoreLocationServiceProvider()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        toHome()
    }
    private func toHome() {
        let homeCoordinator = HomeCoordinator(provider: weatherProvider)
        homeCoordinator.navigationController = navigationController
        start(coordinator: homeCoordinator)
    }
}
