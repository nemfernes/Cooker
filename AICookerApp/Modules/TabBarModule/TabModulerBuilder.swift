//
//  OnboardingAssembler.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct TabModuleBuilder {
    static func build() -> UIViewController {
        let vc = TabViewController(nibName: "TabViewController", bundle: nil)
        return vc
    }
}
