import UIKit

enum IntroPage {
    case first
    case second
    case third
}


class InteractiveWelcomeView: NibView {
    
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = .color18181C
            subtitleLabel.font = .sfMedium15
            subtitleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfSemiBold28
        }
    }
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 16
            containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            containerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var pageImageView: UIImageView! {
        didSet {
            pageImageView.contentMode = .scaleToFill
        }
    }
    
    let data = OnboardingData.data
    public var currentStep: IntroPage = .first
    
    func setup(step: IntroPage) {
        self.backgroundColor = .colorF4F5FA
        currentStep = step
        let index: Int
        switch step {
        case .first: index = 0
        case .second: index = 1
        case .third: index = 2
        }
        
        let item = data[index]
        UIView.transition(with: titleImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleImageView.image = item.image
        }
        
        UIView.transition(with: pageImageView, duration: 0.3, options: .transitionCrossDissolve) {
            self.pageImageView.image = item.pageImage
        }
        
        UIView.transition(with: titleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleLabel.text = item.title
        }
        
        UIView.transition(with: subtitleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.subtitleLabel.text = item.subtitle
        }
    }
}
