//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct DishDetailModuleBuilder {
    
    static func build(dish: Dish) -> DishDetailViewController {
        let vc = DishDetailViewController(dish: dish)
        let router = DishDetailRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
