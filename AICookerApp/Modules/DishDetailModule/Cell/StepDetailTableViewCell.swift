//
//  StepTableViewCell.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import UIKit

class StepDetailTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let reuseId = "StepDetailTableViewCell"
    
    
   
    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
            titleImageView.layer.cornerRadius = 16
            titleImageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfSemiBold14
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!  {
        didSet {
            descriptionLabel.textColor = .color18181C
            descriptionLabel.font = .sfRegular12
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(step: StepRealm, idx: Int) {
        descriptionLabel.text = step.text
        titleLabel.text = "\(LS.Common.Strings.step.localized) \(idx + 1)"
        if let image =  step.image {
            titleImageView.isHidden = false
            titleImageView.image = image
        } else {
            titleImageView.isHidden = true
        }
    }
    
}
