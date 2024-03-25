//
//  NetworkRequest.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 21.03.2024.
//

import Foundation
import Combine

final class NetworkRequest {
    public static let shared = NetworkRequest()
    
    private init() {
        
    }
    
    private var decoder = JSONDecoder()
    
    public func get<ModelItem: Decodable>(urlRequest: URLRequest, urlSession: URLSession) -> AnyPublisher<ModelItem, Error> {
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: ModelItem.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
