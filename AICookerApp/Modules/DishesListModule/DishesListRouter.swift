//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol DishesListRouterProtocol {
    func close()
}

final class DishesListRouter: NSObject, DishesListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
  
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
}
