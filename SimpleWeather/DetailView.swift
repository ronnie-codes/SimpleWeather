//
//  DetailView.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/24/21.
//

import UIKit

final class DetailView: UIView {
    
    // MARK: Title labels (outlets created for localization)
    
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var feelsLikeLabel: UILabel!
    @IBOutlet weak private var visibilityLabel: UILabel!
    @IBOutlet weak private var humidityLabel: UILabel!
    @IBOutlet weak private var speedLabel: UILabel!
    @IBOutlet weak private var degLabel: UILabel!
    
    // MARK: Value labels
    
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
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localize()
    }
    
    private func localize() {
        temperatureLabel.text = R.string.localizable.detailTemperature()
        feelsLikeLabel.text = R.string.localizable.detailFeelsLike()
        visibilityLabel.text = R.string.localizable.detailVisibility()
        humidityLabel.text = R.string.localizable.detailHumidity()
        speedLabel.text = R.string.localizable.detailSpeed()
        degLabel.text = R.string.localizable.detailDeg()
    }
    
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
                    let localizedMeasurement = Measurement<UnitLength>(value: Double(visibility), unit: .meters)
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
