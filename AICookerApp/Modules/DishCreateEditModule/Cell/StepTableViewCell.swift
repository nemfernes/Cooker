//
//  StepTableViewCell.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import UIKit

class StepTableViewCell: UITableViewCell, UITextViewDelegate {
    
    static let reuseId = "StepTableViewCell"
    
    @IBOutlet weak var stepImageContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.text = LS.Common.Strings.myDishes.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfSemiBold14
        }
    }
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var stepImageDeleteButton: UIButton!    {
        didSet {
            stepImageDeleteButton.setImage(.deleteButtonIcon, for: .normal)
            stepImageDeleteButton.addTarget(self, action: #selector(deletePhotoTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var stepImageView: UIImageView! {
        didSet {
            stepImageView.layer.cornerRadius = 16
            stepImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var stepTextView: UITextView! {
        didSet {
            stepTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            stepTextView.delegate = self
            stepTextView.backgroundColor = .white
            stepTextView.layer.cornerRadius = 16
            stepTextView.layer.borderWidth = 1
            stepTextView.layer.borderColor = UIColor.asset(.color_BABAC1).cgColor
            stepTextView.font = .sfRegular14
        }
    }
    @IBOutlet weak var deleteStepButton: UIButton!   {
        didSet {
            deleteStepButton.setImage(.deleteIcon, for: .normal)
            deleteStepButton.addTarget(self, action: #selector(deleteStepTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var cameraButton: UIButton!  {
        didSet {
            cameraButton.setTitle(LS.Common.Strings.takePhoto.localized, for: .normal)
            cameraButton.setTitleColor(.color18181C, for: .normal)
            cameraButton.titleLabel?.font = .sfRegular14
            cameraButton.backgroundColor = UIColor.asset(.color_E9EAEC)
            cameraButton.layer.cornerRadius = 20
            cameraButton.addTarget(self, action: #selector(photoTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var galleryPhotoButton: UIButton!  {
        didSet {
            galleryPhotoButton.setTitle(LS.Common.Strings.photoFromGallery.localized, for: .normal)
            galleryPhotoButton.setTitleColor(.color18181C, for: .normal)
            galleryPhotoButton.titleLabel?.font = .sfRegular14
            galleryPhotoButton.backgroundColor = UIColor.asset(.color_E9EAEC)
            galleryPhotoButton.layer.cornerRadius = 20
            galleryPhotoButton.addTarget(self, action: #selector(galleryTapped), for: .touchUpInside)
        }
    }
    
    private let placeholderText = LS.Common.Strings.finelyChop.localized
    
    var onPickPhotoFromCamera: (() -> Void)?
    var onPickPhotoFromGallery: (() -> Void)?
    var onDeletePhoto: (() -> Void)?
    var onDeleteStep: (() -> Void)?
    var onTextChanged: ((String) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupUI(indexPath: IndexPath, step: StepRealm) {
        
        deleteStepButton.isHidden = (indexPath.row == 0)
        titleLabel.text = LS.Common.Strings.step.localized + " \(indexPath.row + 1)"
        if step.text != "" {
            stepTextView.text = step.text
            stepTextView.textColor = .color18181C
        } else {
            stepTextView.text = placeholderText
            stepTextView.textColor = .color82828E
        }
        
        if let data = step.photoData, let img = UIImage(data: data) {
            stepImageView.image = img
            stepImageContainerView.isHidden = false
            buttonsStackView.isHidden = true
        } else {
            stepImageView.image = nil
            stepImageContainerView.isHidden = true
            buttonsStackView.isHidden = false
        }
    }
    
    @objc private func galleryTapped(_ sender: UIButton) {
        onPickPhotoFromGallery?()
    }
    
    @objc private func photoTapped(_ sender: UIButton) {
        onPickPhotoFromCamera?()
    }
    
    @objc private func deleteStepTapped(_ sender: UIButton) {
        onDeleteStep?()
    }
    
    @objc private func deletePhotoTapped(_ sender: UIButton) {
        onDeletePhoto?()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if stepTextView.text == placeholderText {
            stepTextView.text = ""
            stepTextView.textColor = .color18181C
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let trimmed = stepTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty || trimmed == placeholderText {
            stepTextView.text = placeholderText
            stepTextView.textColor = .color82828E
            onTextChanged?("")
        } else {
            stepTextView.textColor = .color18181C
            onTextChanged?(trimmed)
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

