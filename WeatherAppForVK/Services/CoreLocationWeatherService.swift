//
//  CoreLocationWeatherService.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import CoreLocation
import Combine

enum CoreLocationWeatherServiceError: Error {
    case locationIsNil
    case geocodeError
}
final class CoreLocationWeatherService: WeatherService {
    private let network: WeatherAPIClient
    private let locationPublisher: LocationPublisher
    private var bag = Set<AnyCancellable>()
    private let geocoder = CLGeocoder()
    init(network: WeatherAPIClient, locationPublisher: LocationPublisher) {
        self.network = network
        self.locationPublisher = locationPublisher
    }
    func weather() -> AnyPublisher<Weather.Responce, Error> {
        locationPublisher.$authorizationStatus.sink { [weak self] in
            switch $0 {
            case .notDetermined:
                self?.locationPublisher.requestAuthorization()
            case .authorizedWhenInUse, .authorizedAlways, .denied: // denied for recieving error to a publisher
                self?.locationPublisher.startUpdatingLocation()
            default:
                break
            }
        }.store(in: &bag)
        return locationPublisher.currentLocation
            .handleEvents(receiveOutput: { [unowned self] _ in
                self.locationPublisher.stopUpdatingLocation()
            })
            .flatMap { [unowned self] location -> AnyPublisher<String, Error> in
                guard let location = location else {
                    return Result<String, Error>.failure(CoreLocationWeatherServiceError.locationIsNil)
                        .publisher
                        .eraseToAnyPublisher()
                }
                return self.getLocality(from: location)
            }
            .flatMap { [unowned self] in
                network.fetchWeather(for: $0)
            }
            .eraseToAnyPublisher()
    }
    private func getLocality(from location: CLLocation) -> AnyPublisher<String, Error> {
        let result: PassthroughSubject<String, Error> = .init()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                if let clError = error as? CLError{
                    result.send(completion: .failure(LocationPublisherError.from(clError)))
                }
                
                return
            }
            
            guard let placemarks = placemarks,
                  let placemark = placemarks.first,
                  let locality = placemark.locality else {
                result.send(completion: .failure(CoreLocationWeatherServiceError.geocodeError))
                return
            }
            result.send(locality)
        }
        return result.eraseToAnyPublisher()
    }
}
