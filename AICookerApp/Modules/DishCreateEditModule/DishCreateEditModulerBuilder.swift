//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct DishCreateEditModuleBuilder {
    
    static func build(dish: Dish?) -> DishCreateEditViewController {
        let vc = DishCreateEditViewController(dish: dish)
        let router = DishCreateEditRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
