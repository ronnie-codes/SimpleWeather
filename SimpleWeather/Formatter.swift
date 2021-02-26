//
//  Formatter.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/24/21.
//

import Foundation

struct Formatter {
    static func unit() -> MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter
    }
    static func percent() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
