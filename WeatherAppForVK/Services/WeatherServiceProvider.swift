//
//  WeatherServiceProvider.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 25.03.2024.
//

import Foundation

protocol WeatherServiceProvider {
    func makeWeatherService() -> WeatherService
}

