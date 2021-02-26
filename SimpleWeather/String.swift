//
//  String.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/23/21.
//

import UIKit

extension String {
    // https://developer.apple.com/documentation/mapkit/searching_for_nearby_points_of_interest
    func highlighted(rangeValues: [NSValue]) -> NSAttributedString {
        let text = self
        let attributes = [NSAttributedString.Key.backgroundColor: UIColor.systemYellow.withAlphaComponent(0.25)]
        let highlightedString = NSMutableAttributedString(string: text)
        
        // Each `NSValue` wraps an `NSRange` that can be used as a style attribute's range with `NSAttributedString`.
        let ranges = rangeValues.map { $0.rangeValue }
        ranges.forEach { (range) in
            highlightedString.addAttributes(attributes, range: range)
        }
        
        return highlightedString
    }
}
