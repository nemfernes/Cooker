import UIKit


class DishView: NibView {
    
    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
            titleImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = .sfSemiBold16
        }
    }
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    var pressAction: (() -> Void)?
    
    func setup(title: String, image: UIImage) {
        self.backgroundColor = .white
        titleImageView.image = image
        titleLabel.text = title
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        pressAction?()
    }
}
