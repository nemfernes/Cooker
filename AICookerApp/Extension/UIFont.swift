//
//  UIFont.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit
private extension UIFont {
    enum FontFamily: String {
        case poppins = "Poppins"
    }
    
    enum FontStyle: String {
        case bold = "Bold"
        case semiBold = "SemiBold"
        case regular = "Regular"
        case medium = "Medium"
        case light = "Light"
        case italic = "Italic"
        
        var weight: Weight {
            switch self {
            case .bold:
                return .bold
            case .semiBold:
                return .semibold
            case .regular:
                return .regular
            case .medium:
                return .medium
            case .light:
                return .light
            case .italic: return .regular
            }
        }
    }
    static func getFont(size: CGFloat, family: FontFamily, style: FontStyle) -> UIFont? {
        if family == .poppins {
            if style == .italic {
                return .italicSystemFont(ofSize: size)
            } else {
                return .systemFont(ofSize: size, weight: style.weight)
            }
        }
        let name = "\(family.rawValue)-\(style.rawValue)"
        return UIFont(name: name, size: size)
    }
}

public extension UIFont {
    
    static var sfBold16: UIFont! { return .getFont(size: 16, family: .poppins, style: .bold) }
    static var sfBold18: UIFont! { return .getFont(size: 18, family: .poppins, style: .bold) }
    static var sfBold20: UIFont! { return .getFont(size: 20, family: .poppins, style: .bold) }
    static var sfBold26: UIFont! { return .getFont(size: 26, family: .poppins, style: .bold) }
    static var sfBold24: UIFont! { return .getFont(size: 24, family: .poppins, style: .bold) }
    static var sfBold23: UIFont! { return .getFont(size: 23, family: .poppins, style: .bold) }
    static var sfBold14: UIFont! { return .getFont(size: 14, family: .poppins, style: .bold) }
    static var sfBold34: UIFont! { return .getFont(size: 34, family: .poppins, style: .bold) }
    static var sfBold30: UIFont! { return .getFont(size: 30, family: .poppins, style: .bold) }
    static var sfSemiBold30: UIFont! { return .getFont(size: 30, family: .poppins, style: .semiBold) }
    static var sfSemiBold28: UIFont! { return .getFont(size: 28, family: .poppins, style: .semiBold) }
    static var sfSemiBold26: UIFont! { return .getFont(size: 26, family: .poppins, style: .semiBold) }
    static var sfSemiBold24: UIFont! { return .getFont(size: 26, family: .poppins, style: .semiBold) }
    static var sfSemiBold20: UIFont! { return .getFont(size: 20, family: .poppins, style: .semiBold) }
    static var sfSemiBold18: UIFont! { return .getFont(size: 18, family: .poppins, style: .semiBold) }
    static var sfSemiBold16: UIFont! { return .getFont(size: 16, family: .poppins, style: .semiBold) }
    static var sfSemiBold15: UIFont! { return .getFont(size: 15, family: .poppins, style: .semiBold) }
    static var sfSemiBold14: UIFont! { return .getFont(size: 14, family: .poppins, style: .semiBold) }
    static var sfSemiBold13: UIFont! { return .getFont(size: 13, family: .poppins, style: .semiBold) }
    static var sfSemiBold11: UIFont! { return .getFont(size: 11, family: .poppins, style: .semiBold) }

    static var sfMedium30: UIFont! { return .getFont(size: 30, family: .poppins, style: .medium) }
    static var sfMedium28: UIFont! { return .getFont(size: 28, family: .poppins, style: .medium) }
    static var sfMedium20: UIFont! { return .getFont(size: 20, family: .poppins, style: .medium) }
    static var sfMedium18: UIFont! { return .getFont(size: 18, family: .poppins, style: .medium) }
    static var sfMedium17: UIFont! { return .getFont(size: 17, family: .poppins, style: .medium) }
    static var sfMedium16: UIFont! { return .getFont(size: 16, family: .poppins, style: .medium) }
    static var sfMedium15: UIFont! { return .getFont(size: 16, family: .poppins, style: .medium) }
    static var sfMedium14: UIFont! { return .getFont(size: 14, family: .poppins, style: .medium) }
    static var sfMedium12: UIFont! { return .getFont(size: 12, family: .poppins, style: .medium) }
    static var sfMedium13: UIFont! { return .getFont(size: 13, family: .poppins, style: .medium) }
    static var sfMedium11: UIFont! { return .getFont(size: 11, family: .poppins, style: .medium) }

    static var sfRegular20: UIFont! { return .getFont(size: 20, family: .poppins, style: .regular) }
    static var sfRegular18: UIFont! { return .getFont(size: 17, family: .poppins, style: .regular) }
    static var sfRegular17: UIFont! { return .getFont(size: 17, family: .poppins, style: .regular) }
    static var sfRegular16: UIFont! { return .getFont(size: 16, family: .poppins, style: .regular) }
    static var sfRegular15: UIFont! { return .getFont(size: 15, family: .poppins, style: .regular) }
    static var sfRegular14: UIFont! { return .getFont(size: 14, family: .poppins, style: .regular) }
    static var sfRegular12: UIFont! { return .getFont(size: 12, family: .poppins, style: .regular) }

    static var sfMedium10: UIFont! { return .getFont(size: 10, family: .poppins, style: .medium) }
    static var sfMedium9: UIFont! { return .getFont(size: 9, family: .poppins, style: .medium) }

    static var sfLight16: UIFont! { return .getFont(size: 16, family: .poppins, style: .light) }

    static var sfItalic15: UIFont! { return .getFont(size: 15, family: .poppins, style: .italic) }
}
