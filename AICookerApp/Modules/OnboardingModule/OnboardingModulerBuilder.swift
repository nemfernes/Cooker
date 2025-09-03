//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct OnboardingModuleBuilder {
    static func build() -> UIViewController {
        let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let router = OnboardingRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
