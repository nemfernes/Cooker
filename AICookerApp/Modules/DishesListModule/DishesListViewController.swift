//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit
import RealmSwift

class DishesListViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: LS.Common.Strings.pumpkinSoup.localized,
                attributes: [
                    .foregroundColor: UIColor.color82828E,
                    .font: UIFont.sfSemiBold16
                ]
            )
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 0))
            searchTextField.leftView = paddingView
            searchTextField.leftViewMode = .always
            searchTextField.placeholder = LS.Common.Strings.pumpkinSoup.localized
            searchTextField.textColor = .color18181C
            searchTextField.backgroundColor = .white
            searchTextField.font =  UIFont.sfSemiBold16
            searchTextField.layer.cornerRadius = 20
            searchTextField.delegate = self
            searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var noResultSubtitleLabel: UILabel!  {
        didSet {
            noResultSubtitleLabel.text = LS.Common.Strings.perhapsThis.localized
            noResultSubtitleLabel.textColor = .color18181C
            noResultSubtitleLabel.font = .sfMedium18
        }
    }
    @IBOutlet weak var noResultTitleLabel: UILabel!  {
        didSet {
            noResultTitleLabel.text = LS.Common.Strings.notFound.localized
            noResultTitleLabel.textColor = .color18181C
            noResultTitleLabel.font = .sfMedium16
        }
    }
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var defaultView: UIView!
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
            addButton.layer.cornerRadius = 25
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        }
    }
    
    var router: DishesListRouterProtocol?
    private var dishType: DishType
    private var allDishes: Results<Dish>? {
        didSet {
            setupInitUI()
        }
    }
    private var dishes: Results<Dish>?
    
    init(dishType: DishType) {
        self.dishType = dishType
        super.init(nibName: "DishesListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDishes()
        updateNoResultsView()
        dishesTableView.reloadData()
    }
    
    private func setupInitUI() {
        self.titleLabel.text = dishType.title
        updateNoResultsView()
    }
        
    private func updateNoResultsView() {
        let hasDishes = !(dishes?.isEmpty ?? true)
        let hasAllDishes = !(allDishes?.isEmpty ?? true)
        let isSearching = !(searchTextField.text?.isEmpty ?? true)
        
        if isSearching && !hasDishes {
            noResultsView.isHidden = false
            dishesTableView.isHidden = true
            defaultView.isHidden = true
            return
        }
        
        if !hasAllDishes {
            defaultView.isHidden = false
            dishesTableView.isHidden = true
            noResultsView.isHidden = true
            searchView.isHidden = true
            return
        }
        
        dishesTableView.isHidden = false
        defaultView.isHidden = true
        noResultsView.isHidden = true
    }
    
    private func setupTableView() {
           dishesTableView.dataSource = self
           dishesTableView.delegate = self
           dishesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
           dishesTableView.rowHeight = UITableView.automaticDimension
           dishesTableView.estimatedRowHeight = 120
           dishesTableView.register(
               UINib(nibName: "DishTableViewCell", bundle: nil),
               forCellReuseIdentifier: DishTableViewCell.reuseId
           )
       }
    
    private func loadDishes() {
        allDishes = DatabaseManager.shared
            .getAll(Dish.self)
            .filter("type == %@", dishType.rawValue)
        dishes = allDishes
    }
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        let query = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            dishes = allDishes
        } else {
            dishes = allDishes?.filter("name CONTAINS[c] %@", query)
        }
        
        updateNoResultsView()
        dishesTableView.reloadData()
    }
    
    @objc private func addTapped(_ sender: UIButton) {
        router?.goToDish(dishType: self.dishType, dish: nil)
    }
    
    @objc private func backTapped(_ sender: UIButton) {
        self.router?.close()
    }
}


extension DishesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = dishes?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dish = dishes?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
                withIdentifier: DishTableViewCell.reuseId,
                for: indexPath
              ) as? DishTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupUI(dish: dish)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dish = dishes?[indexPath.row] else { return }
        //router?.goToDish(dish: dish)
    }
}
