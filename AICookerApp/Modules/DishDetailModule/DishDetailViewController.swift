//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit
import RealmSwift


class DishDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.myDishes.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    
    var router: DishesRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }
    
    func setupAction() {
       
    }
}
