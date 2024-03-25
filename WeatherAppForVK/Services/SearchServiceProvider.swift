//
//  SearchServiceProvider.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation

protocol SearchServiceProvider {
    func makeSearchService() -> SearchService
}
