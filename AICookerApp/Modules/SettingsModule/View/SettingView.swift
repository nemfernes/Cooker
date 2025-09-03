import UIKit


class SettingView: NibView {
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.textColor = UIColor.asset(.color_18181C)
            titleLabel.font = .sfLight16
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
