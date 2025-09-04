
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfRegular14
        }
    }
    @IBOutlet weak var titleImageView: UIImageView!
    static let reuseId = "CategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .black : .white
            titleLabel.textColor = isSelected ? .white : .color18181C
            titleImageView.tintColor = isSelected ? .white : .color18181C
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 15
        containerView.backgroundColor = .white
    }

    
    func setup(data: CategoryModel) {
        self.titleLabel.text = data.name
        self.titleImageView.image = data.image.withRenderingMode(.alwaysTemplate)
        titleImageView.tintColor = .color18181C
    }
    
}
