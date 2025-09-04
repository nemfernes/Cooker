//
//  AICookingViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit

class AICookingViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
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
            addButton.layer.cornerRadius = 28
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        }
    }
    
    var router: AICookingRouterProtocol?
    let categoryData = CategoryData.data
    let selectedCategory: DishType = .mainCourses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
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
    
    @objc private func addTapped(_ sender: UIButton) {
        
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
        let selectedCategory = categoryData[indexPath.row]
        print("Выбрана категория: \(selectedCategory.name)")
    }
}
