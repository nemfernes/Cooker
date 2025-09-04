//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct AICookingModuleBuilder {
    
    static func build() -> AICookingViewController {
        let vc = AICookingViewController()
        let router = AICookingRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
