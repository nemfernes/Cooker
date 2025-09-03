//
//  Router.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 29.08.2025.
//

import Foundation
import UIKit

// MARK: - Router Protocol

protocol RootRouterProtocol {
    var navigationController: UINavigationController? { get set }
    
    func setRoot(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
}

final class RootRouter: RootRouterProtocol {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func setRoot(_ viewController: UIViewController, animated: Bool) {
        navigationController?.setViewControllers([viewController], animated: animated)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
}

// MARK: - Example: Opening specific screens

extension RootRouter {
    
    func openOnboarding() {
        let vc = OnboardingModuleBuilder.build()
        push(vc, animated: true)
    }
    
    func openTab() {
        let vc = TabModuleBuilder.build()
        push(vc, animated: true)
    }
}
