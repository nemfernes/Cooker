//
//  OnboardingRouter.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import MessageUI
import UIKit

protocol SettingsRouterProtocol {
    func close()
    func sendEmail()
    func shareLink(_ url: URL)
    func openLink(_ urlString: String)
}

final class SettingsRouter: NSObject, SettingsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(
                title: "Error",
                message: "Mail services are not available",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController?.present(alert, animated: true)
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.setToRecipients(["MykhailoBoyko683@icloud.com"])
        composer.mailComposeDelegate = self
        viewController?.present(composer, animated: true)
    }
    
    // MARK: - Share
    func shareLink(_ url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = viewController?.view
        viewController?.present(activityVC, animated: true)
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
}

extension SettingsRouter: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}
