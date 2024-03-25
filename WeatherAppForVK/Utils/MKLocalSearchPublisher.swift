//
//  MKLocalSearchPublisher.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import MapKit
import Combine

final class MKLocalSearchPublisher: NSObject, MKLocalSearchCompleterDelegate {
    
    var query: String {
        set {
            completer.queryFragment = newValue
        }
        get {
            completer.queryFragment
        }
    }
    let results: PassthroughSubject<[MKLocalSearchCompletion], Error> = .init()
    
    private let completer: MKLocalSearchCompleter
    
    init(localSearchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()) {
        self.completer = localSearchCompleter
        super.init()
        completer.delegate = self
        completer.resultTypes = .address
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results.send(completer.results)
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        results.send(completion: .failure(error))
    }
}
