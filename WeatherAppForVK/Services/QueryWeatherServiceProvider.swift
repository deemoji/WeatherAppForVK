//
//  QueryWeatherServiceProvider.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation

final class QueryWeatherServiceProvider: WeatherServiceProvider {
    private let city: String
    private let network = WeatherAPIClient()
    
    init(_ city: String) {
        self.city = city
    }
    
    func makeWeatherService() -> WeatherService {
        return QueryWeatherService(network: network, city: city)
    }
    
}
