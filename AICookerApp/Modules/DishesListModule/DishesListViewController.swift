//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit

class DishesListViewController: UIViewController {
    
    @IBOutlet weak var defaultImageView: UIImageView! {
        didSet {
            defaultImageView.image = .asset(.defaultFoodImage)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.myDishes.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    
    @IBOutlet weak var backButton: UIButton!  {
        didSet {
            backButton.setImage(.arrowBackIcon, for: .normal)
            backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var submainLabel: UILabel!  {
        didSet {
            submainLabel.text = LS.Common.Strings.addFirst.localized
            submainLabel.textColor = .color82828E
            submainLabel.font = .sfRegular14
            submainLabel.numberOfLines = 0
            submainLabel.textAlignment = .center
        }
    }
    @IBOutlet weak var mainLabel: UILabel!  {
        didSet {
            mainLabel.text = LS.Common.Strings.noRecipts.localized
            mainLabel.textColor = .black
            mainLabel.font = .sfMedium18
            mainLabel.numberOfLines = 0
            mainLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var addButton: UIButton!  {
        didSet {
            addButton.setTitle(LS.Common.Strings.addRecipt.localized, for: .normal)
            addButton.setTitleColor(.white, for: .normal)
            addButton.titleLabel?.font = .sfSemiBold16
            addButton.backgroundColor = UIColor.asset(.color_1E1E1E)
            addButton.layer.cornerRadius = 28
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        }
    }
    
    var router: DishesListRouterProtocol?
    private var dishType: DishType
    
    init(dishType: DishType) {
        self.dishType = dishType
        super.init(nibName: "DishesListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @objc private func addTapped(_ sender: UIButton) {
        router?.goToDish(dish: nil)
    }
    
    @objc private func backTapped(_ sender: UIButton) {
        self.router?.close()
    }
}
