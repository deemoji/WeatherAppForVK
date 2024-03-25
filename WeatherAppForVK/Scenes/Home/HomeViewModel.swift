//
//  HomeViewModel.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import Foundation
import Combine

enum HomeViewModelState {
   case loading
    case finishedLoading
    case error(Error)
}
enum HomeItem {
    case mainInfo(MainInfoViewModel)
    case dailyItem(DailyItemViewModel)
}
extension HomeItem: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .mainInfo(let mainInfoViewModel):
            hasher.combine(mainInfoViewModel)
        case .dailyItem(let dailyItemViewModel):
            hasher.combine(dailyItemViewModel)
        }
    }
    
}
final class HomeViewModel {
    enum Section {
        case mainInfo
        case dailyItems
    }
    @Published private(set) var weather: Weather.Responce = .empty
    @Published private(set) var state: HomeViewModelState = .loading
    
    private var bag = Set<AnyCancellable>()
    
    private let service: WeatherService
    
    init(service: WeatherService) {
        self.service = service
    }
    func fetchWeather() {
        service.weather().sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error)
            case .finished:
                self?.state = .finishedLoading
            }
        } receiveValue: { [weak self] responce in
            self?.weather = responce
            self?.state = .finishedLoading
        }.store(in: &bag)
    }
}
