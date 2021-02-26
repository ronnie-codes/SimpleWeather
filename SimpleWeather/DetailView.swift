//
//  DetailView.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/24/21.
//

import UIKit

final class DetailView: UIView {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var tempActualLabel: UILabel!
    @IBOutlet weak private var tempFeelsLikeLabel: UILabel!
    @IBOutlet weak private var cloudsVisibilityLabel: UILabel!
    @IBOutlet weak private var cloudsHumidityLabel: UILabel!
    @IBOutlet weak private var windSpeedLabel: UILabel!
    @IBOutlet weak private var windDegLabel: UILabel!
    
    lazy private var unitFormatter = Formatter.unit()
    lazy private var percentFormatter = Formatter.percent()
    
    func configure(for city: CityDetailsQuery.Data.GetCityByName) {
        titleLabel.text = city.name
        
        // TODO: Refactor
        if let weather = city.weather {
            if let summary = weather.summary {
                descriptionLabel.text = summary.description?.capitalized
            }
            if let temp = weather.temperature {
                if let actual = temp.actual {
                    let localizedMeasurement = Measurement<UnitTemperature>(value: actual, unit: .kelvin)
                    tempActualLabel.text = unitFormatter.string(from: localizedMeasurement)
                }
                if let feelsLike = temp.feelsLike {
                    let localizedMeasurement = Measurement<UnitTemperature>(value: feelsLike, unit: .kelvin)
                    tempFeelsLikeLabel.text = unitFormatter.string(from: localizedMeasurement)
                }
            }
            if let clouds = weather.clouds {
                if let visibility = clouds.visibility {
                    let localizedMeasurement = Measurement<UnitLength>(value: Double(visibility), unit: .kilometers)
                    cloudsVisibilityLabel.text = unitFormatter.string(for: localizedMeasurement)
                }
                if let humidity = clouds.humidity {
                    cloudsHumidityLabel.text = percentFormatter.string(from: NSDecimalNumber(decimal: Decimal(humidity)/100.0))
                }
            }
            if let wind = weather.wind {
                if let speed = wind.speed {
                    let localizedMeasurement = Measurement<UnitSpeed>(value: speed, unit: .knots)
                    windSpeedLabel.text = unitFormatter.string(from: localizedMeasurement)
                }
                if let deg = wind.deg {
                    let localizedMeasurement = Measurement<UnitAngle>(value: Double(deg), unit: .degrees)
                    windDegLabel.text = unitFormatter.string(from: localizedMeasurement)
                }
            }
        }
    }
}
