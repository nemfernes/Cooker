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
    func goToDish(dish: Dish)
    func goToEditCreate(dishType: DishType, dish: Dish?)
}

final class DishesListRouter: NSObject, DishesListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
  
    func goToEditCreate(dishType: DishType, dish: Dish?) {
        let nextVC = DishCreateEditModuleBuilder.build(dishType: dishType, dish: dish)
        nextVC.modalPresentationStyle = .fullScreen
        viewController?.present(nextVC, animated: true)
       
    }
    
    func goToDish(dish: Dish) {
        let nextVC = DishDetailModuleBuilder.build(dish: dish)
        nextVC.modalPresentationStyle = .fullScreen
        viewController?.present(nextVC, animated: true)
       
    }
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
}
