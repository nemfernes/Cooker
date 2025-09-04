//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol DishCreateEditRouterProtocol {
    func close()
    func showSettingsAlert()
}

final class DishCreateEditRouter: NSObject, DishCreateEditRouterProtocol {
    
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
    
    func showSettingsAlert() {
        let alert = UIAlertController(
            title: LS.Common.Strings.alert.localized, message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: LS.Common.Strings.alertCancel.localized, style: .cancel))
        alert.addAction(UIAlertAction(title: LS.Common.Strings.settings.localized, style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        viewController?.present(alert, animated: true)
    }
}
