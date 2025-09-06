//
//  TabViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit

enum Tab {
    case ai
    case myDishes
    case settings
}

class TabViewController: UIViewController {
    
    
    @IBOutlet weak var settingsLabel: UILabel!   {
        didSet {
            settingsLabel.textColor = UIColor.asset(.color_1E1E1E)
            settingsLabel.text = LS.Common.Strings.settings.localized
            settingsLabel.font = .sfMedium12
        }
    }
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var aiCookingLabel: UILabel!   {
        didSet {
            aiCookingLabel.textColor = UIColor.asset(.color_1E1E1E)
            aiCookingLabel.text = LS.Common.Strings.aiCooking.localized
            aiCookingLabel.font = .sfMedium12
        }
    }
    @IBOutlet weak var aiCookingImageView: UIImageView!
    @IBOutlet weak var aiCookingButton: UIButton! {
        didSet {
            aiCookingButton.addTarget(self, action: #selector(aiReceiptButtonTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var myDishesImageView: UIImageView!
    @IBOutlet weak var myDishesLabel: UILabel!   {
        didSet {
            myDishesLabel.textColor = UIColor.asset(.color_1E1E1E)
            myDishesLabel.text = LS.Common.Strings.myDishes.localized
            myDishesLabel.font = .sfMedium12
        }
    }
    @IBOutlet weak var myDishesButton: UIButton! {
        didSet {
            myDishesButton.addTarget(self, action: #selector(myDishesButtonTapped), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var containerView: UIView!
    private var currentVC: UIViewController?
    private var selectedTab: Tab = .ai
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.showMain = true
        let homeVC = AICookingModuleBuilder.build()
        setupUI(tab: .ai)
        switchTo(homeVC)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func switchTo(_ vc: UIViewController) {
        if let currentVC {
            removeEmbedded(currentVC)
        }
        embed(vc, in: containerView)
        currentVC = vc
    }
    
    @objc private func myDishesButtonTapped(_ sender: UIButton) {
        setupUI(tab: .myDishes)
        let dishesVC = DishesModuleBuilder.build()
        let dishesNav = UINavigationController(rootViewController: dishesVC)
        dishesNav.setNavigationBarHidden(true, animated: false)
        switchTo(dishesNav)
    }
    
    @objc private func aiReceiptButtonTapped(_ sender: UIButton) {
        setupUI(tab: .ai)
        let homeVC = AICookingModuleBuilder.build()
        switchTo(homeVC)
    }
    
    @objc private func settingsButtonTapped(_ sender: UIButton) {
        setupUI(tab: .settings)
        let setitngs = SettingsModuleBuilder.build()
        switchTo(setitngs)
    }
    
    func setupUI(tab: Tab) {
        switch tab {
        case .ai:
            aiCookingLabel.textColor = UIColor.asset(.color_1E1E1E)
            aiCookingImageView.image = UIImage.asset(.tab1Active)
            
            myDishesLabel.textColor = UIColor.asset(.color_BABAC1)
            myDishesImageView.image = UIImage.asset(.tab2Inactive)
            
            settingsLabel.textColor = UIColor.asset(.color_BABAC1)
            settingsImageView.image = UIImage.asset(.tab3Inactive)
        case .myDishes:
            myDishesLabel.textColor = UIColor.asset(.color_1E1E1E)
            myDishesImageView.image = UIImage.asset(.tab2Active)
            
            aiCookingLabel.textColor = UIColor.asset(.color_BABAC1)
            aiCookingImageView.image = UIImage.asset(.tab1Inactive)
            
            settingsLabel.textColor = UIColor.asset(.color_BABAC1)
            settingsImageView.image = UIImage.asset(.tab3Inactive)
        case .settings:
            settingsLabel.textColor = UIColor.asset(.color_1E1E1E)
            settingsImageView.image = UIImage.asset(.tab3Active)
            
            aiCookingLabel.textColor = UIColor.asset(.color_BABAC1)
            aiCookingImageView.image = UIImage.asset(.tab1Inactive)
            
            myDishesLabel.textColor = UIColor.asset(.color_BABAC1)
            myDishesImageView.image = UIImage.asset(.tab2Inactive)
        }
    }
    
    func removeEmbedded(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
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
}
