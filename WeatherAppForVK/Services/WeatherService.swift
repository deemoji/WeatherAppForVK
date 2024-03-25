//
//  WeatherService.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 21.03.2024.
//

import Foundation
import Combine

protocol WeatherService {
    func weather() -> AnyPublisher<Weather.Responce, Error>
}
