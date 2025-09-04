//
//  CategoryModel.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import Foundation
import UIKit

struct CategoryModel {
    let name: String
    let image: UIImage
    let category: DishType
}


struct CategoryData {
    static let data: [CategoryModel] = [
        CategoryModel(name: LS.Common.Strings.mainCourses.localized, image: .meatIcon, category: .mainCourses),
        CategoryModel(name: LS.Common.Strings.soups.localized, image: .soupIcon, category: .soups),
        CategoryModel(name: LS.Common.Strings.salads.localized, image: .carrotIcon, category: .salads),
        CategoryModel(name: LS.Common.Strings.breakfasts.localized, image: .coffeeIcon, category: .breakfasts),
        CategoryModel(name: LS.Common.Strings.appetizers.localized, image: .cheeseIcon, category: .appetizer),
        CategoryModel(name: LS.Common.Strings.desserts.localized, image: .lollipopIcon, category: .desserts),
        CategoryModel(name: LS.Common.Strings.drinks.localized, image: .drinksIcon, category: .drinks)
        ]
}
