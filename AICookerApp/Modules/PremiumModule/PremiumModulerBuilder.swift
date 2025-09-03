//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct PremiumModuleBuilder {
    
    static func build() -> PremiumViewController {
        let vc = PremiumViewController(placement: .onboarding)
        let router = PremiumRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
