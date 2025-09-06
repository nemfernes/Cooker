//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol DishDetailRouterProtocol {
    func close()
    func share(dish: Dish)
    func showDeleteAlert(confirmHandler: @escaping () -> Void)
    func goToEdit(dishType: DishType, dish: Dish)
}

final class DishDetailRouter: NSObject, DishDetailRouterProtocol {
    
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
    
    func goToEdit(dishType: DishType, dish: Dish) {
        let nextVC = DishCreateEditModuleBuilder.build(dishType: dishType, dish: dish)
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.onClose = { [weak self] dish in
               if let vc = self?.viewController as? DishDetailViewController {
                   vc.updateModel(dish: dish)
               }
           }
        viewController?.present(nextVC, animated: true)
       
    }
    
    func share(dish: Dish) {
        var items: [Any] = []
        var text = "\(LS.Common.Strings.name.localized): \(dish.name)\n"
            text += "\(LS.Common.Strings.ingredinets.localized):\n\(dish.ingredients)\n\n"

            for (index, step) in dish.steps.enumerated() {
                text += "\(LS.Common.Strings.step.localized) \(index + 1): \(step.text)\n"
            }

            items.append(text)

        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(activityVC, animated: true)
    }
    
    func showDeleteAlert(confirmHandler: @escaping () -> Void) {
            let alert = UIAlertController(
                title: LS.Common.Strings.deleteRecipe.localized,
                message: LS.Common.Strings.dataWill.localized,
                preferredStyle: .alert
            )
            
        alert.addAction(UIAlertAction(title: LS.Common.Strings.alertCancel.localized, style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: LS.Common.Strings.delete.localized, style: .destructive, handler: { _ in
                confirmHandler()
            }))
            
            viewController?.present(alert, animated: true)
        }
}
