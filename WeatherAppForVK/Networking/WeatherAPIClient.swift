//
//  WeatherAPIClient.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 21.03.2024.
//

import Foundation
import Combine

final class WeatherAPIClient {
    
    private let host = "weather.visualcrossing.com"
    private let path = "/VisualCrossingWebServices/rest/services/timeline/"
    private let apiKey = "LF7RV8CHLECR4BQ3LTQ38AW9R"
    private var urlSession = URLSession.shared
    
    func fetchWeather(for city: String) -> AnyPublisher<Weather.Responce, Error> {
        guard let request = makeURLRequest(for: city) else {
            return Fail(outputType: Weather.Responce.self, failure: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        return NetworkRequest.shared.get(urlRequest: request, urlSession: urlSession)
    }
    
    private func makeURLRequest(for city: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path + city
        components.queryItems = [
            URLQueryItem(name: "unitGroup", value: "metric"),
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "contentType", value: "json")
        ]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
