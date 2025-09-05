//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocolDishDetailRouterProtocol {
    func close()
    func goToDishesList(type: DishType)
}

final class DishDetailRouter: NSObject, DishDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func goToDishesList(type: DishType) {
        let nextVC = DishesListModuleBuilder.build(dishType: type)
        if let tabVC = viewController?.parent as? TabViewController {
                    tabVC.switchTo(nextVC)
                    tabVC.setupUI(tab: .myDishes)
                } else {
                    viewController?.navigationController?.pushViewController(nextVC, animated: true)
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
