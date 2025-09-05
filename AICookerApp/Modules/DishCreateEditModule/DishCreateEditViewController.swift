//
//  DishesViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//
import Photos
import UIKit
import RealmSwift
import AVFoundation

struct Step {
    let title: String
    var image: UIImage?
}

class DishCreateEditViewController: UIViewController {
    
    
    @IBOutlet weak var photoButtonsView: UIView!
    @IBOutlet weak var subStackView: UIStackView!
    @IBOutlet weak var image3Button: UIButton! {
        didSet {
            image3Button.addTarget(self, action: #selector(imageDeleteButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var photosStackView: UIStackView!
    @IBOutlet weak var image3ContainerView: UIView! {
        didSet {
            image3ContainerView.clipsToBounds = true
            image3ContainerView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var image3View: UIImageView!
    @IBOutlet weak var image2Button: UIButton!{
        didSet {
            image2Button.addTarget(self, action: #selector(imageDeleteButtonTapped(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image2ContainerView: UIView! {
        didSet {
            image2ContainerView.clipsToBounds = true
            image2ContainerView.layer.cornerRadius = 16
        }
    }
    
    @IBOutlet weak var image1ContainerView: UIView! {
        didSet {
            image1ContainerView.clipsToBounds = true
            image1ContainerView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var image1Button: UIButton! {
        didSet {
            image1Button.addTarget(self, action: #selector(imageDeleteButtonTapped(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var image1View: UIImageView!
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
    @IBOutlet weak var galleryButton: UIButton!   {
        didSet {
            galleryButton.setTitle(LS.Common.Strings.photoFromGallery.localized, for: .normal)
            galleryButton.setTitleColor(.color18181C, for: .normal)
            galleryButton.titleLabel?.font = .sfRegular14
            galleryButton.backgroundColor = UIColor.asset(.color_E9EAEC)
            galleryButton.layer.cornerRadius = 20
            galleryButton.addTarget(self, action: #selector(galleryTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var backButton: UIButton!   {
        didSet {
            backButton.setImage(.arrowBackIcon, for: .normal)
            backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!  {
        didSet {
            titleLabel.text = LS.Common.Strings.createRecept.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    @IBOutlet weak var instructionLabel: UILabel!  {
        didSet {
            instructionLabel.text = LS.Common.Strings.instructions.localized + ":"
            instructionLabel.textColor = .color18181C
            instructionLabel.font = .sfSemiBold18
        }
    }
    @IBOutlet weak var ingredientsTextView: UITextView!  {
        didSet {
            ingredientsTextView.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            ingredientsTextView.delegate = self
            ingredientsTextView.backgroundColor = .white
            ingredientsTextView.layer.cornerRadius = 16
            ingredientsTextView.layer.borderWidth = 1
            ingredientsTextView.layer.borderColor = UIColor.asset(.color_BABAC1).cgColor
            ingredientsTextView.font = .sfRegular14
        }
    }
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.setTitle(LS.Common.Strings.saveRecept.localized.uppercased(), for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.titleLabel?.font = .sfSemiBold16
            saveButton.backgroundColor = UIColor.asset(.color_1E1E1E)
            saveButton.layer.cornerRadius = 25
            saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var addStepButton: UIButton! {
        didSet {
            addStepButton.setTitle(LS.Common.Strings.addStep.localized.uppercased(), for: .normal)
            addStepButton.setTitleColor(.color18181C, for: .normal)
            addStepButton.titleLabel?.font = .sfSemiBold16
            addStepButton.backgroundColor = .clear
            addStepButton.layer.borderWidth = 1
            addStepButton.layer.borderColor = UIColor.asset(.color_1E1E1E).cgColor
            addStepButton.layer.cornerRadius = 25
            addStepButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var stepTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.attributedPlaceholder = NSAttributedString(
                string: LS.Common.Strings.pumpkinSoup.localized,
                attributes: [
                    .foregroundColor: UIColor.color82828E,
                    .font: UIFont.sfSemiBold16
                ]
            )
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
            nameTextField.leftView = paddingView
            nameTextField.leftViewMode = .always
            nameTextField.placeholder = LS.Common.Strings.pumpkinSoup.localized
            nameTextField.textColor = .color18181C
            nameTextField.backgroundColor = .white
            nameTextField.layer.borderWidth = 1
            nameTextField.font =  UIFont.sfSemiBold16
            nameTextField.layer.borderColor = UIColor.asset(.color_BABAC1).cgColor
            nameTextField.layer.cornerRadius = 25
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var ingredientsLabel: UILabel!  {
        didSet {
            ingredientsLabel.text = LS.Common.Strings.ingredinets.localized
            ingredientsLabel.textColor = .color18181C
            ingredientsLabel.font = .sfSemiBold18
        }
    }
    @IBOutlet weak var nameLabel: UILabel!  {
        didSet {
            nameLabel.text = LS.Common.Strings.name.localized + ":"
            nameLabel.textColor = .color18181C
            nameLabel.font = .sfSemiBold18
        }
    }
    
    
    @IBOutlet weak var tableViewHeightConstr: NSLayoutConstraint!
    var router: DishCreateEditRouterProtocol?
    
    private let placeholderText = LS.Common.Strings.pumpkin500.localized
    private let namePlaceholder = LS.Common.Strings.pumpkinSoup.localized
    private var currentDish: Dish
    private var dishType: DishType
    private var isEditingExisting: Bool
    private var isDishPhotoPicking = false
    private var dishPhotoIndex: Int?
    
    init(dishType: DishType, dish: Dish?) {
        if let dish {
            self.currentDish = dish
            self.isEditingExisting = true
        } else {
            self.currentDish = Dish()
            self.currentDish.steps.append(StepRealm())
            self.currentDish.type = dishType.rawValue
            self.isEditingExisting = false
        }
        self.dishType = dishType
        super.init(nibName: "DishCreateEditViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTable()
    }
    
    private func setupTableView() {
        stepTableView.dataSource = self
        stepTableView.delegate = self
        stepTableView.rowHeight = UITableView.automaticDimension
        stepTableView.estimatedRowHeight = 150
        stepTableView.register(
            UINib(nibName: "StepTableViewCell", bundle: nil),
            forCellReuseIdentifier: StepTableViewCell.reuseId
        )
    }
    
    private func setupUI() {
        updatePhotoViews()
        
        if currentDish.ingredients.isEmpty {
            ingredientsTextView.text = placeholderText
            ingredientsTextView.textColor = .color82828E
        } else {
            ingredientsTextView.text = currentDish.ingredients
            ingredientsTextView.textColor = .color18181C
        }
    }
    
    private func updatePhotoViews() {
        let images = currentDish.images
        let photoViews = [
            (image1ContainerView, image1View),
            (image2ContainerView, image2View),
            (image3ContainerView, image3View)
        ]
        
        for (index, (container, imageView)) in photoViews.enumerated() {
            if index < images.count {
                container?.isHidden = false
                imageView?.image = images[index]
            } else {
                container?.isHidden = true
                imageView?.image = nil
            }
        }
        
        let hideSubStack = (image2ContainerView.isHidden && image3ContainerView.isHidden)
        subStackView.isHidden = hideSubStack
        
        let allHidden = photoViews.allSatisfy { (container, _) in
            container?.isHidden == true
        }
        photosStackView.isHidden = allHidden
        
        photoButtonsView.isHidden = (images.count == 3)
    }
    
    private func validateAndMark() -> Bool {
        var isValid = true
        let red = UIColor.red.cgColor
        let normal = UIColor.asset(.color_BABAC1).cgColor

        let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if name.isEmpty || name == namePlaceholder {
            nameTextField.layer.borderColor = red
            isValid = false
        } else {
            nameTextField.layer.borderColor = normal
        }

        let ingredients = ingredientsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if ingredients.isEmpty || ingredients == placeholderText {
            ingredientsTextView.layer.borderColor = red
            isValid = false
        } else {
            ingredientsTextView.layer.borderColor = normal
        }

        if currentDish.photos.isEmpty {
            galleryButton.layer.borderWidth = 1
            galleryButton.layer.borderColor = red
            cameraButton.layer.borderWidth = 1
            cameraButton.layer.borderColor = red
            isValid = false
        } else {
            galleryButton.layer.borderWidth = 0
            cameraButton.layer.borderWidth = 0
        }

        var hasStepWithText = false
            for (index, step) in currentDish.steps.enumerated() {
                let txt = step.text.trimmingCharacters(in: .whitespacesAndNewlines)
                let isEmpty = txt.isEmpty

                if let cell = stepTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? StepTableViewCell {
                    cell.stepTextView.layer.borderColor = isEmpty ? red : normal
                }

                if !isEmpty {
                    hasStepWithText = true
                }
            }

            if !hasStepWithText { isValid = false }

        return isValid
    }

    
    @objc private func addTapped(_ sender: UIButton) {
        let emptyStep = StepRealm()
        currentDish.steps.append(emptyStep)
        self.reloadTable()
    }
    
    @objc private func saveTapped(_ sender: UIButton) {
        guard validateAndMark() else { return }
        currentDish.name = nameTextField.text ?? ""
        currentDish.ingredients = ingredientsTextView.text ?? ""
        
        if isEditingExisting {
            DatabaseManager.shared.update(currentDish) {}
        } else {
            DatabaseManager.shared.add(currentDish)
        }
        router?.close()
    }
    
    @objc private func backTapped(_ sender: UIButton) {
        self.router?.close()
    }
    
    @objc private func galleryTapped(_ sender: UIButton) {
        isDishPhotoPicking = true
        dishPhotoIndex = nil
        presentImagePicker(sourceType: .photoLibrary, for: -1)
    }
    
    @objc private func photoTapped(_ sender: UIButton) {
        isDishPhotoPicking = true
        dishPhotoIndex = nil
        presentImagePicker(sourceType: .camera, for: -1)
    }
    
    @objc private func imageDeleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag - 1
        guard index >= 0, index < currentDish.photos.count else { return }
        
        DatabaseManager.shared.update(currentDish) {
            currentDish.photos.remove(at: index)
        }
        
        updatePhotoViews()
    }
    
    public func reloadTable() {
        tableViewHeightConstr.constant = CGFloat.greatestFiniteMagnitude
        stepTableView.reloadData()
        stepTableView.layoutIfNeeded()
        tableViewHeightConstr.constant = stepTableView.contentSize.height + 10
    }
    
    func requestCameraAccess(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        default:
            completion(false)
        }
    }
    
    func requestPhotoAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        default:
            completion(false)
        }
    }
}

extension DishCreateEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDish.steps.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StepTableViewCell.reuseId,
            for: indexPath
        ) as? StepTableViewCell else {
            return UITableViewCell()
        }
        
        let step = currentDish.steps[indexPath.row]
        
        cell.setupUI(indexPath: indexPath, step: step)
        
        cell.onPickPhotoFromCamera = { [weak self] in
            self?.isDishPhotoPicking = false
            self?.presentImagePicker(sourceType: .camera, for: indexPath.row)
        }
        cell.onPickPhotoFromGallery = { [weak self] in
            self?.isDishPhotoPicking = false
            self?.presentImagePicker(sourceType: .photoLibrary, for: indexPath.row)
        }
        cell.onDeletePhoto = { [weak self] in
            DatabaseManager.shared.update(step) {
                step.photoData = nil
            }
            self?.reloadTable()
        }
        cell.onDeleteStep = { [weak self] in
            guard let self else { return }
            let step = self.currentDish.steps[indexPath.row]
            
            DatabaseManager.shared.update(self.currentDish) {
                self.currentDish.steps.remove(at: indexPath.row)
                self.currentDish.realm?.delete(step)
            }
            
            self.reloadTable()
        }
        
        cell.onTextChanged = { [weak self] text in
            guard let self else { return }
            let step = self.currentDish.steps[indexPath.row]
            DatabaseManager.shared.update(step) {
                step.text = text
            }
        }
        return cell
    }
}

extension DishCreateEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePicker(sourceType: UIImagePickerController.SourceType, for index: Int) {
        if sourceType == .camera {
            requestCameraAccess { [weak self] granted in
                guard granted else {
                    self?.router?.showSettingsAlert()
                    return
                }
                self?.openImagePicker(sourceType: .camera, index: index)
            }
        } else if sourceType == .photoLibrary {
            requestPhotoAccess { [weak self] granted in
                guard granted else {
                    self?.router?.showSettingsAlert()
                    return
                }
                self?.openImagePicker(sourceType: .photoLibrary, index: index)
            }
        }
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType, index: Int) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.view.tag = index
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                guard let image = info[.editedImage] as? UIImage ??
                        info[.originalImage] as? UIImage else { return }
                
                let data = image.jpegData(compressionQuality: 0.85)
                
                if self.isDishPhotoPicking {
                    DatabaseManager.shared.update(self.currentDish) {
                        if self.currentDish.photos.count < 3 {
                            self.currentDish.photos.append(data!)
                        } else {
                            self.currentDish.photos[0] = data!
                        }
                    }
                    self.updatePhotoViews()
                } else {
                    let index = picker.view.tag
                    guard index >= 0, index < self.currentDish.steps.count else { return }
                    let step = self.currentDish.steps[index]
                    
                    DatabaseManager.shared.update(step) {
                        step.photoData = data
                    }
                    self.reloadTable()
                }
            }
        }
    }
    
    
}

extension DishCreateEditViewController: UITextFieldDelegate, UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if ingredientsTextView.text == placeholderText {
            ingredientsTextView.text = ""
            ingredientsTextView.textColor = .color18181C
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let trimmed = ingredientsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty || trimmed == placeholderText {
            ingredientsTextView.text = placeholderText
            ingredientsTextView.textColor = .color82828E
        } else {
            ingredientsTextView.textColor = .color18181C
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        DatabaseManager.shared.update(currentDish) {
            currentDish.ingredients = trimmed
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField, textField.text == namePlaceholder {
            textField.text = ""
            textField.textColor = .color18181C
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            let trimmed = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            if trimmed.isEmpty {
                textField.text = namePlaceholder
                textField.textColor = .color82828E
            } else {
                textField.textColor = .color18181C
            }
            DatabaseManager.shared.update(currentDish) {
                currentDish.name = trimmed
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameTextField {
            let trimmed = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            DatabaseManager.shared.update(currentDish) {
                currentDish.name = trimmed
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
