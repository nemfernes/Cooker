//
//  String.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

public extension String {
    func getUnderline() -> NSMutableAttributedString {
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return NSMutableAttributedString(
            string: self,
            attributes: yourAttributes
        )
    }
}
