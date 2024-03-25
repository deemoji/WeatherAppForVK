//
//  QueryWeatherService.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import Combine

final class QueryWeatherService: WeatherService {
    
    private let network: WeatherAPIClient
    private let city: String
    
    init(network: WeatherAPIClient = WeatherAPIClient(), city: String) {
        self.network = network
        self.city = city
    }
    func weather() -> AnyPublisher<Weather.Responce, Error> {
        network.fetchWeather(for: city)
    }
    
}
