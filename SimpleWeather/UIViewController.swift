//
//  UIViewController.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/23/21.
//

import UIKit

extension UIViewController {
    func delay(timeInterval: Double = 0.35, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: completion)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertOk(), style: .default))
        self.present(alert, animated: true)
    }
}
