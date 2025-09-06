//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol AICookingRouterProtocol {
    func close()
    func goToDish(dish: Dish)
    func goToPremium()
    func showErrorAlert()
}

final class AICookingRouter: AICookingRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
  
    func goToDish(dish: Dish) {
        let nextVC = DishAIDetailModuleBuilder.build(dish: dish)
        nextVC.modalPresentationStyle = .fullScreen
        viewController?.present(nextVC, animated: true)
       
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error occured", message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController?.present(alert, animated: true)
    }
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
    func goToPremium() {
        let nextVC = PremiumModuleBuilder.build()
        nextVC.modalPresentationStyle = .fullScreen
        viewController?.present(nextVC, animated: true)
       
    }
}
