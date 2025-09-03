//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct SettingsModuleBuilder {
    
    static func build() -> SettingsViewController {
        let vc = SettingsViewController()
        let router = SettingsRouter(viewController: vc)
        vc.router = router
        return vc
    }
}
