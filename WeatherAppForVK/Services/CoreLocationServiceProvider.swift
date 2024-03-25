//
//  CoreLocationServiceProvider.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation

final class CoreLocationServiceProvider: WeatherServiceProvider {
    private let network = WeatherAPIClient()
    private let locationPublisher = LocationPublisher()
    func makeWeatherService() -> WeatherService {
        locationPublisher.requestAuthorization()
        return CoreLocationWeatherService(network: network, locationPublisher: locationPublisher)
    }
    
    
}
