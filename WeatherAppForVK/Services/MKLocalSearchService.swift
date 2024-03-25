//
//  MKLocalSearchService.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import Combine

final class MKLocalSearchService: SearchService {
    
    private let publisher: MKLocalSearchPublisher
    
    init(_ publisher: MKLocalSearchPublisher = MKLocalSearchPublisher()) {
        self.publisher = publisher
    }
    
    func search(with query: String) -> AnyPublisher<[String], Error> {
        publisher.query = query
        return publisher.results.map {
            $0.map { $0.title }
        }.eraseToAnyPublisher()
    }
}
