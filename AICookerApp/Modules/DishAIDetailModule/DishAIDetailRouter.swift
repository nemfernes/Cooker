//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol DishAIDetailRouterProtocol {
    func close()
    func share(dish: Dish)
    func showDeleteAlert(confirmHandler: @escaping () -> Void)
    func showSuccessAlert()
}

final class DishAIDetailRouter: NSObject, DishAIDetailRouterProtocol {
    
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
    func showSuccessAlert() {
        let alert = UIAlertController(
            title: LS.Common.Strings.successAdded.localized, message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController?.present(alert, animated: true)
    }
}
