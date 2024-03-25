//
//  SearchViewModel.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 24.03.2024.
//

import Foundation
import Combine

final class SearchViewModel {
    enum Section { case cities }
    
    @Published var results: [String] = []
    
    let selectedCity = PassthroughSubject<String, Never>()
    let selectedItem = PassthroughSubject<Int,Never>()
    
    let viewWillDisappear = PassthroughSubject<Void, Never>()
    
    private let service: SearchService
    private var bag = Set<AnyCancellable>()
    
    init(_ service: SearchService) {
        self.service = service
        selectedItem.sink { [unowned self] in
            self.selectedCity.send(self.results[$0])
        }.store(in: &bag)
    }
    
    func search(with query: String) {
        service.search(with: query).sink { error in
            print(error)
        } receiveValue: { [weak self] in
            self?.results = $0
        }.store(in: &bag)
    }
    
}
