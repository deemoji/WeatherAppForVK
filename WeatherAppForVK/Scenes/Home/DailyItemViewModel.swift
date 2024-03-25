//
//  DailyItemViewModel.swift
//  WeatherAppForVK
//
//  Created by Дмитрий Мартьянов on 23.03.2024.
//

import Foundation

struct DailyItemViewModel {
    let monthDay: String
    let weekday: String
    let icon: String
    let minTemp: String
    let maxTemp: String
}

extension DailyItemViewModel: Hashable {}

extension DailyItemViewModel {
    init(day: Weather.Day) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE,MMM d"
        dateFormatter.locale = .init(identifier: "en_US")
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(day.datetimeEpoch)))
        let currentDateString = dateFormatter.string(from: Date())
        let components = dateString.components(separatedBy: ",")
        self.monthDay = components[1]
        self.weekday = dateString == currentDateString ? "Today" : components[0]
        self.icon = day.icon
        self.minTemp = String(Int(day.tempMin)) + "°"
        self.maxTemp = String(Int(day.tempMax)) + "°"
    }
}
