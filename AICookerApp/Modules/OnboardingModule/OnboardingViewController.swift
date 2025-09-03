//
//  OnboardingViewController.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import UIKit

class OnboardingViewController: UIViewController, PremiumViewControllerDelegate {
    
    @IBOutlet weak var welcomeView: InteractiveWelcomeView!
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.setTitle(LS.Common.Strings.continueButton.localized, for: .normal)
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.titleLabel?.font = .sfSemiBold16
            continueButton.backgroundColor = UIColor.asset(.color_1E1E1E)
            continueButton.layer.cornerRadius = 28
            continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        }
    }
    
    var router: OnboardingRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeView.setup(step: .first)
    }

    @objc private func continueTapped(_ sender: UIButton) {
        switch welcomeView.currentStep {
        case .first:
            welcomeView.setup(step: .second)
        case .second:
            welcomeView.setup(step: .third)
        case .third:
            router?.openPremiumScreen()
        }
    }
    
    func premiumViewControllerDidClose(_ controller: PremiumViewController) {
        self.router?.openTabbarScreen()
    }
}
