//
//  UIView.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/24/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
