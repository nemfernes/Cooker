//
//  TabViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit

class TabViewController: UIViewController {

    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var aiCookingLabel: UILabel!
    @IBOutlet weak var aiCookingImageView: UIImageView!
    @IBOutlet weak var aiCookingButton: UIButton! {
        didSet {
            aiCookingButton.addTarget(self, action: #selector(aiReceiptButtonTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var myDishesImageView: UIImageView!
    @IBOutlet weak var myDishesLabel: UILabel!
    @IBOutlet weak var myDishesButton: UIButton! {
        didSet {
            myDishesButton.addTarget(self, action: #selector(myDishesButtonTapped), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var containerView: UIView!
    private var currentVC: UIViewController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let homeVC = AICookingViewController()
            switchTo(homeVC)
        }
        
        func switchTo(_ vc: UIViewController) {
                if let currentVC {
                    removeEmbedded(currentVC)
                }
                embed(vc, in: containerView)
                currentVC = vc
            }

        @objc private func myDishesButtonTapped(_ sender: UIButton) {
            let dishesVC = DishesViewController()
            switchTo(dishesVC)
        }
        
        @objc private func aiReceiptButtonTapped(_ sender: UIButton) {
            let homeVC = AICookingViewController()
            switchTo(homeVC)
        }
        
        @objc private func settingsButtonTapped(_ sender: UIButton) {
            let setitngs = SettingsViewController()
            switchTo(setitngs)
        }
    }


    extension UIViewController {
        func embed(_ child: UIViewController, in container: UIView) {
            addChild(child)
            child.view.frame = container.bounds
            container.addSubview(child.view)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                child.view.topAnchor.constraint(equalTo: container.topAnchor),
                child.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                child.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                child.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            ])
            child.didMove(toParent: self)
        }
        
        func removeEmbedded(_ child: UIViewController) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
