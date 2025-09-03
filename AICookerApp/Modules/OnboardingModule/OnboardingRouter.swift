//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation


import UIKit

protocol OnboardingRouterProtocol {
    func openPremiumScreen()
    func openTabbarScreen()
    func close()
}

final class OnboardingRouter: OnboardingRouterProtocol {
    
    weak var viewController: OnboardingViewController?
    
    init(viewController: OnboardingViewController?) {
        self.viewController = viewController
    }
    
    func openPremiumScreen() {
        let nextVC = PremiumModuleBuilder.build()
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.delegate = viewController
        viewController?.present(nextVC, animated: true)
    }
    
    func openTabbarScreen() {
        let tabbar = TabViewController()
        tabbar.modalPresentationStyle = .fullScreen

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.rootViewController = tabbar
            window.makeKeyAndVisible()
        }
    }
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
}

