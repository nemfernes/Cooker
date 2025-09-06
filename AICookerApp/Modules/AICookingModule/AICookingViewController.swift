//
//  AICookingViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit
import RealmSwift

class AICookingViewController: BaseViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var dishTableView: UITableView!
    @IBOutlet weak var defaultImageView: UIImageView! {
        didSet {
            defaultImageView.image = .asset(.defaultFoodImage)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.aiCooking.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    
    @IBOutlet weak var submainLabel: UILabel!  {
        didSet {
            submainLabel.text = LS.Common.Strings.selectCategory.localized
            submainLabel.textColor = .color82828E
            submainLabel.font = .sfRegular14
            submainLabel.numberOfLines = 0
            submainLabel.textAlignment = .center
        }
    }
    @IBOutlet weak var mainLabel: UILabel!  {
        didSet {
            mainLabel.text = LS.Common.Strings.urAIRecipe.localized
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
    
    var router: AICookingRouterProtocol?
    let categoryData = CategoryData.data
    private var dishes: Results<Dish>?
    var selectedCategory: DishType = .mainCourses {
        didSet {
            reloadView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadView()
    }
    
    
    func setupCollectionView() {
        guard let flowLayout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        categoryCollectionView.allowsMultipleSelection = false
        categoryCollectionView.backgroundColor = .clear
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseId
        )
        DispatchQueue.main.async {
               let firstIndexPath = IndexPath(item: 0, section: 0)
               self.categoryCollectionView.selectItem(
                   at: firstIndexPath,
                   animated: false,
                   scrollPosition: []
               )
               self.collectionView(self.categoryCollectionView, didSelectItemAt: firstIndexPath)
           }
    }
    
    private func reloadView() {
        loadDishesFromCategory()
        updateNoResultsView()
        dishTableView.reloadData()
    }
    
    private func updateNoResultsView() {
        let hasDishes = !(dishes?.isEmpty ?? true)
        
        if !hasDishes {
            noResultView.isHidden = false
            dishTableView.isHidden = true
            return
        }
        
        dishTableView.isHidden = false
        noResultView.isHidden = true
    }
    
    private func setupTableView() {
        dishTableView.dataSource = self
        dishTableView.delegate = self
        dishTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        dishTableView.rowHeight = UITableView.automaticDimension
        dishTableView.estimatedRowHeight = 120
        dishTableView.register(
               UINib(nibName: "DishTableViewCell", bundle: nil),
               forCellReuseIdentifier: DishTableViewCell.reuseId
           )
       }
    
    private func loadDishesFromCategory() {
        dishes = DatabaseManager.shared
               .getAll(Dish.self)
               .filter("type == %@ AND isAIGenerated == true", selectedCategory.request)
    }
    
    private func loadDishes()-> Int {
        dishes = DatabaseManager.shared
            .getAll(Dish.self)
        return dishes?.count ?? 0
    }
    
    @objc private func addTapped(_ sender: UIButton) {
        if !UserDefaults.premium && loadDishes() > 5 {
            self.router?.goToPremium()
        } else {
            getDish()
        }
    }
    
   private func getDish() {
       let category = selectedCategory.request
       let locale = Locale.current.language.languageCode?.identifier ?? "en"
       let userId = UserDefaults.adaptyUserId
       self.addLoadingView()
       APIManager.shared.generateReceipt(category: category,
                                                locale: locale,
                                                userId: userId) { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let receipt):
                   let dish = Dish(from: receipt) {
                       self.dishTableView.reloadData()
                       }
                   DatabaseManager.shared.add(dish)
                   self.reloadView()
                   self.removeLoadingView()
               case .failure(let error):
                   self.removeLoadingView()
                   self.router?.showErrorAlert()
                   print("\(error.localizedDescription)")
               }
           }
       }
    }
}

extension AICookingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseId, for: indexPath) as! CategoryCollectionViewCell
        cell.setup(data: categoryData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategory = categoryData[indexPath.row].category
    }
}

extension AICookingViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        router?.goToDish(dish: dish)
    }
}
