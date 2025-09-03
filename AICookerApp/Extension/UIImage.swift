//
//  UIImage.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

extension UIImage {
    enum Asset: String {
        case spashIcon
        case checkboxEmptyIcon
        case checkboxFilledIcon
        case onboarding1Image
        case onboarding2Image
        case onboarding3Image
        case pagination1
        case pagination2
        case pagination3
        case premiumTitleImage
        case tab1Active
        case tab2Active
        case tab3Active
        case tab1Inactive
        case tab2Inactive
        case tab3Inactive
        case carrotIcon
        case cheeseIcon
        case chefHatIcon
        case coffeeIcon
        case drinksIcon
        case lollipopIcon
        case meatIcon
        case soupIcon
        case noFoodsImage
        case appetizersImage
        case breakfastImage
        case dessertsImage
        case drinksImage
        case mainCousineImage
        case saladsImage
        case soupImage
        case mailIcon
        case arrowIcon
        case privacyIcon
        case restoreIcon
        case shareIcon
        case termsIcon
        case arrowBackIcon
        case defaultFoodImage
    }
    
    static func asset(_ name: Asset) -> UIImage {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
}
