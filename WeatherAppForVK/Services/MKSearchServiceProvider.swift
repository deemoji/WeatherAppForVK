//
//  MKSearchServiceProvider.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation

final class MKSearchServiceProvider: SearchServiceProvider {
    func makeSearchService() -> SearchService {
        return MKLocalSearchService()
    }
}
