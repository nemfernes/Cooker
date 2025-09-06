// DishDetailViewController.swift

import UIKit
import RealmSwift

class DishAIDetailViewController: UIViewController {

    @IBOutlet weak var subStackView: UIStackView!
  
    @IBOutlet weak var stepTableView: UITableView!
    @IBOutlet weak var stepTitleLabel: UILabel!   {
        didSet {
            stepTitleLabel.font = .sfSemiBold18
            stepTitleLabel.textColor = .color18181C
            stepTitleLabel.text = LS.Common.Strings.instructions.localized
        }
    }
    @IBOutlet weak var ingredientsLabel: UILabel!   {
        didSet {
            ingredientsLabel.font = .sfRegular12
            ingredientsLabel.textColor = .color18181C
        }
    }
    @IBOutlet weak var ingridientsTitleLabel: UILabel!   {
        didSet {
            ingridientsTitleLabel.font = .sfSemiBold18
            ingridientsTitleLabel.textColor = .color18181C
            ingridientsTitleLabel.text = LS.Common.Strings.ingredinets.localized
        }
    }
   
    @IBOutlet weak var addButton: UIButton!   {
        didSet {
            addButton.setTitle(LS.Common.Strings.addToDishes.localized, for: .normal)
            addButton.setTitleColor(.white, for: .normal)
            addButton.titleLabel?.font = .sfSemiBold16
            addButton.backgroundColor = UIColor.asset(.color_1E1E1E)
            addButton.layer.cornerRadius = 25
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!   {
        didSet {
            nameLabel.font = .sfSemiBold24
            nameLabel.textColor = .color18181C
        }
    }
    @IBOutlet weak var shareButton: UIButton!  {
        didSet {
            shareButton.setImage(.shareIcon, for: .normal)
            shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var deleteButton: UIButton!   {
        didSet {
            deleteButton.setImage(.deleteDetailIcon, for: .normal)
            deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var backButton: UIButton!    {
        didSet {
            backButton.setImage(.arrowBackIcon, for: .normal)
            backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.detail.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }

    
    @IBOutlet weak var stepTableHeightConstr: NSLayoutConstraint!
    var router: DishAIDetailRouterProtocol?
    var dish: Dish


    init(dish: Dish) {
        self.dish = dish
        super.init(nibName: "DishAIDetailViewController", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAppearance()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTable()
    }

    private func setupAppearance() {
        [image1View, image2View, image3View].forEach {
            $0?.contentMode = .scaleAspectFill
            $0?.clipsToBounds = true
            $0?.layer.cornerRadius = 16
        }
        stepTitleLabel.text = LS.Common.Strings.instructions.localized + ":"
        nameLabel.textColor = .color18181C
        nameLabel.font = .sfSemiBold18
        ingredientsLabel.textColor = .color18181C
        ingredientsLabel.font = .sfRegular14
    }

    func configureUI() {
        nameLabel.text = dish.name
        ingredientsLabel.text = dish.ingredients

        let images = dish.images
        let imageViews: [UIImageView] = [image1View, image2View, image3View].compactMap { $0 }

        for (idx, iv) in imageViews.enumerated() {
            if idx < images.count {
                iv.isHidden = false
                iv.image = images[idx]
            } else {
                iv.isHidden = true
                iv.image = nil
            }
        }
        subStackView.isHidden = image2View.isHidden && image3View.isHidden
    }
    
    func updateModel(dish: Dish) {
        self.dish = dish
        configureUI()
        reloadTable()
    }


    private func setupTableView() {
           stepTableView.dataSource = self
           stepTableView.delegate = self
           stepTableView.rowHeight = UITableView.automaticDimension
           stepTableView.estimatedRowHeight = 120
           stepTableView.isScrollEnabled = false
           stepTableView.separatorStyle = .none

           stepTableView.register(
               UINib(nibName: "StepDetailTableViewCell", bundle: nil),
               forCellReuseIdentifier: StepDetailTableViewCell.reuseId
           )
       }

    public func reloadTable() {
        stepTableHeightConstr.constant = CGFloat.greatestFiniteMagnitude
        stepTableView.reloadData()
        stepTableView.layoutIfNeeded()
        stepTableHeightConstr.constant = stepTableView.contentSize.height + 10
    }

    
    @objc private func backTapped(_ sender: UIButton) {
        self.router?.close()
    }
    
    @objc private func deleteTapped(_ sender: UIButton) {
        router?.showDeleteAlert { [weak self] in
               guard let self else { return }
               DatabaseManager.shared.delete(self.dish)
               self.router?.close()
           }
    }
    
    @objc private func shareTapped(_ sender: UIButton) {
        self.router?.share(dish: dish)
    }
    
    @objc private func addTapped(_ sender: UIButton) {
        DatabaseManager.shared.update(self.dish) {
            self.dish.isAIGenerated = false
        }
    }
}

extension DishAIDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dish.steps.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StepDetailTableViewCell.reuseId,
            for: indexPath
        ) as? StepDetailTableViewCell else {
            return UITableViewCell()
        }

        let step = dish.steps[indexPath.row]
        cell.setup(step: step, idx: indexPath.row)
        return cell
    }
}
