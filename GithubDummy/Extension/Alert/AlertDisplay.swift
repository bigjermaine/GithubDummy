//
//  AlertDisplay.swift
//  Jamit
//
//  Created by MacBook AIR on 27/02/2024.
//

import Foundation
import UIKit


class Alert {
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
