//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct DishDetailModuleBuilder {
    
    static func build() -> DishDetailViewController {
        let vc = DishDetailViewController()
        let router = DishDetailRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
