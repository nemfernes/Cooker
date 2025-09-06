//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct DishAIDetailModuleBuilder {
    
    static func build(dish: Dish) -> DishAIDetailViewController {
        let vc = DishAIDetailViewController(dish: dish)
        let router = DishAIDetailRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
