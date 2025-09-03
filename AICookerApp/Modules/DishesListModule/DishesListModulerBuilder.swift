//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct DishesListModuleBuilder {
    
    static func build(dishType: DishType) -> DishesListViewController {
        let vc = DishesListViewController(dishType: dishType)
        let router = DishesListRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
