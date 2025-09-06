//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit
import RealmSwift

enum DishType: String {
    case soups
    case salads
    case desserts
    case breakfasts
    case mainCourses
    case drinks
    case appetizer
    
    var title: String {
            switch self {
            case .soups:
                return LS.Common.Strings.soups.localized
            case .salads:
                return LS.Common.Strings.salads.localized
            case .desserts:
                return LS.Common.Strings.desserts.localized
            case .breakfasts:
                return LS.Common.Strings.breakfasts.localized
            case .mainCourses:
                return LS.Common.Strings.mainCourses.localized
            case .drinks:
                return LS.Common.Strings.drinks.localized
            case .appetizer:
                return LS.Common.Strings.appetizers.localized
            }
        }
    
    var request: String {
        switch self {
        case .soups:
            return "Soups"
        case .salads:
            return "Salads"
        case .desserts:
            return "Desserts"
        case .breakfasts:
            return "Breakfasts"
        case .mainCourses:
            return "Main Courses"
        case .drinks:
            return "Drinks"
        case .appetizer:
            return "Appetizers"
        }
    }
}

class DishesViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.myDishes.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    
    
    @IBOutlet weak var breakfastView: DishView!  {
        didSet {
            breakfastView.clipsToBounds = true
            breakfastView.layer.cornerRadius = 12
            breakfastView.setup(title: LS.Common.Strings.breakfasts.localized, image: .breakfast)
        }
    }
    @IBOutlet weak var drinksView: DishView!  {
        didSet {
            drinksView.clipsToBounds = true
            drinksView.layer.cornerRadius = 12
            drinksView.setup(title: LS.Common.Strings.drinks.localized, image: .drinks)
        }
    }
    @IBOutlet weak var mainView: DishView!  {
        didSet {
            mainView.clipsToBounds = true
            mainView.layer.cornerRadius = 12
            mainView.setup(title: LS.Common.Strings.mainCourses.localized, image: .mainCousine)
        }
    }
    @IBOutlet weak var dessertView: DishView! {
        didSet {
            dessertView.clipsToBounds = true
            dessertView.layer.cornerRadius = 12
            dessertView.setup(title: LS.Common.Strings.desserts.localized, image: .asset(.dessertsImage))
        }
    }
    @IBOutlet weak var soupView: DishView!  {
        didSet {
            soupView.clipsToBounds = true
            soupView.layer.cornerRadius = 12
            soupView.setup(title: LS.Common.Strings.soups.localized, image: .soup)
        }
    }
    
    @IBOutlet weak var saladsView: DishView!  {
        didSet {
            saladsView.clipsToBounds = true
            saladsView.layer.cornerRadius = 12
            saladsView.setup(title: LS.Common.Strings.salads.localized, image: .salads)
        }
    }
    
    @IBOutlet weak var dessertsView: DishView!  {
        didSet {
            dessertsView.clipsToBounds = true
            dessertsView.layer.cornerRadius = 12
            dessertsView.setup(title: LS.Common.Strings.desserts.localized, image: .asset(.dessertsImage))
        }
    }
    @IBOutlet weak var appetizerView: DishView!  {
        didSet {
            appetizerView.clipsToBounds = true
            appetizerView.layer.cornerRadius = 12
            appetizerView.setup(title: LS.Common.Strings.appetizers.localized, image: .appetizers)
        }
    }
    
    var router: DishesRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAction()
    }
    
    func setupAction() {
        soupView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .soups)
        }
        saladsView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .salads)
        }
        mainView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .mainCourses)
        }
        appetizerView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .appetizer)
        }
        dessertView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .desserts)
        }
        drinksView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .drinks)
        }
        breakfastView.pressAction = { [weak self] in
            guard let self else {return}
            self.router?.goToDishesList(type: .breakfasts)
        }
    }
}
