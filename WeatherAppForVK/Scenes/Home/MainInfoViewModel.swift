//
//  MainInfoViewModel.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import Foundation

struct MainInfoViewModel {
    
    let locationName: String
    
    let temp: String
    
    let windspeed: String
    
    let cloudCover: String
    
    let precibProb: String
    
}
extension MainInfoViewModel: Hashable { }

extension MainInfoViewModel {
    init(_ address: String, day: Weather.Day) {
        self.locationName = address
        self.temp = String(Int(day.temp)) + "°"
        self.windspeed = String(day.windspeed) + "m/s"
        self.cloudCover = String(day.cloudCover) + "%"
        self.precibProb = String(day.precipProbability) + "%"
    }
}
