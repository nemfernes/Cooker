//
//  UIColor.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

extension UIColor {
    enum Asset: String {
        case color_F4F5FA
        case color_82828E
        case color_18181C
        case color_71B94D
        case color_1E1E1E
    }

    static func asset(_ name: Asset,
                      in bundle: Bundle = .main,
                      compatibleWith traitCollection: UITraitCollection? = nil) -> UIColor {
        UIColor(named: name.rawValue, in: bundle, compatibleWith: traitCollection)
        ?? .clear
    }
}
