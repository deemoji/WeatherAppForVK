//
//  SearchService.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import Combine

protocol SearchService {
    func search(with query: String) -> AnyPublisher<[String], Error>
}
