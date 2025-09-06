import UIKit


class StepView: UIView {
    
    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
            titleImageView.layer.cornerRadius = 16
            titleImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.textColor = .white
            titleLabel.font = .sfSemiBold16
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setup(step: StepRealm, idx: Int) {
        titleLabel.text = step.text
        descriptionLabel.text = "\(LS.Common.Strings.step.localized) \(idx + 1)"
        if let image =  step.image {
            titleImageView.isHidden = false
            titleImageView.image = image
        } else {
            titleImageView.isHidden = true
        }
    }
    
    func loadFromNib() -> StepView {
           let nib = UINib(nibName: "StepView", bundle: nil)
           return nib.instantiate(withOwner: nil, options: nil).first as! StepView
       }
}
