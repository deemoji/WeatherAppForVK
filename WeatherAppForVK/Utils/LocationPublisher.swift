//
//  LocationPublisher.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import CoreLocation
import Combine

enum LocationPublisherError: Error {
    case locationUnknown
    case denied
    case network
    case unknown
}

extension LocationPublisherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .locationUnknown:
            return NSLocalizedString("The location is unknown. Please try again.", comment: "LocationPublisherError")
        case .denied:
            return NSLocalizedString("The access to your location is denied.", comment: "LocationPublisherError")
        case .network:
            return NSLocalizedString("The network is unavilable.", comment: "LocationPublisherError")
        case .unknown:
            return NSLocalizedString("Unknown publisher error.", comment: "LocationPublisherError")
        }
    }
    static func from(_ error: CLError) -> LocationPublisherError {
        switch error.code {
        case .locationUnknown:
            return .locationUnknown
        case .denied:
            return .denied
        case .network:
            return .network
        default:
            return .unknown
        }
    }
}
class LocationPublisher: NSObject, CLLocationManagerDelegate {
    
    var currentLocation = PassthroughSubject<CLLocation?, Error>()
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    private let locationManager: CLLocationManager
    
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        
        locationManager.delegate = self
    }
    
    static func locality(from location: CLLocation) -> AnyPublisher<String, Error> {
        let geocoder = CLGeocoder()
        let result: PassthroughSubject<String, Error> = .init()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
                result.send(completion: .failure(error))
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
    func requestAuthorization() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation.send(locations.last) 
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            self.currentLocation.send(completion: .failure(LocationPublisherError.from(clError)))
        }
        self.currentLocation.send(completion: .failure(error))
    }
}
