//
//  StepTableViewCell.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import UIKit

class DishTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let reuseId = "DishTableViewCell"
    
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
            containerView.backgroundColor = .white
        }
    }
    @IBOutlet weak var subStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfSemiBold16
        }
    }
    
    
    @IBOutlet weak var image2View: UIImageView!  {
        didSet {
            image2View.layer.cornerRadius = 16
            image2View.clipsToBounds = true
        }
    }
    @IBOutlet weak var image1View: UIImageView!  {
        didSet {
            image1View.layer.cornerRadius = 16
            image1View.clipsToBounds = true
        }
    }
    @IBOutlet weak var image3View: UIImageView!  {
        didSet {
            image3View.layer.cornerRadius = 16
            image3View.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupUI(dish: Dish) {
        titleLabel.text = dish.name
        let images = dish.images
        
        let imageViews = [image1View, image2View, image3View]
        
        for (index, imageView) in imageViews.enumerated() {
            if index < images.count {
                imageView?.isHidden = false
                imageView?.image = images[index]
            } else {
                imageView?.isHidden = true
                imageView?.image = nil
            }
        }
        let hideSubStack = (image2View.isHidden && image3View.isHidden)
        subStackView.isHidden = hideSubStack
    }
    
}
