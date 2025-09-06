//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation


import UIKit

protocol PremiumRouterProtocol {
    func openNextScreen(with message: String)
    func close()
    func openLink(_ urlString: String)
    func showErrorAlert()
}

final class PremiumRouter: PremiumRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func openNextScreen(with message: String) {
//        let nextVC = NextViewController()
//        nextVC.message = message
//        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func close() {
        if let nav = viewController?.navigationController {
            nav.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
    func openLink(_ urlString: String) {
           guard let url = URL(string: urlString) else { return }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       }
    
    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error occured", message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController?.present(alert, animated: true)
    }
}

