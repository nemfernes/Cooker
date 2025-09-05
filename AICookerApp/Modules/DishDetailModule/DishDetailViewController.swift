//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit
import RealmSwift

class DishDetailViewController: UIViewController {
    
    @IBOutlet weak var subStackView: UIStackView!
    @IBOutlet weak var stepStackView: UIStackView!
    @IBOutlet weak var stepTitleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var ingridientsTitleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.myDishes.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    
    var router: DishDetailRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
