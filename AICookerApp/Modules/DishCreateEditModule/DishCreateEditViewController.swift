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
            nameTextField.placeholder = LS.Common.Strings.pumpkinSoup.localized
            nameTextField.backgroundColor = .white
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = UIColor.asset(.color_BABAC1).cgColor
            nameTextField.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var ingredientsLabel: UILabel!  {
        didSet {
            ingredientsLabel.text = LS.Common.Strings.ingredinets.localized + ":"
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
    
    private var steps = List<StepRealm>()
    private var dish: Dish?
    
    init(dish: Dish?) {
        self.dish = dish
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
        if let dish {
            steps = dish.steps
            ingredientsTextView.text = dish.ingredients
        } else {
            let emptyStep = StepRealm()
            steps.append(emptyStep)
            
            
            if let dish {
                ingredientsTextView.text = dish.ingredients
                ingredientsTextView.textColor = .color18181C
            } else {
                ingredientsTextView.text = placeholderText
                ingredientsTextView.textColor = .color82828E
            }
        }
    }
    
    @objc private func addTapped(_ sender: UIButton) {
        let emptyStep = StepRealm()
        steps.append(emptyStep)
        self.reloadTable()
    }
    
    @objc private func saveTapped(_ sender: UIButton) {
       
    }
    
    @objc private func backTapped(_ sender: UIButton) {
        self.router?.close()
    }
    
    @objc private func galleryTapped(_ sender: UIButton) {
       
    }
    
    @objc private func photoTapped(_ sender: UIButton) {
       
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
        return steps.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StepTableViewCell.reuseId,
            for: indexPath
        ) as? StepTableViewCell else {
            return UITableViewCell()
        }
        
        let step = steps[indexPath.row]
        
        cell.setupUI(indexPath: indexPath, step: step)
        
        cell.onPickPhotoFromCamera = { [weak self] in
                self?.presentImagePicker(sourceType: .camera, for: indexPath.row)
            }
            cell.onPickPhotoFromGallery = { [weak self] in
                self?.presentImagePicker(sourceType: .photoLibrary, for: indexPath.row)
            }
            cell.onDeletePhoto = { [weak self] in
                DatabaseManager.shared.update(step) {
                        step.photoData = nil
                    }
                    self?.reloadTable()
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

                let index = picker.view.tag
                guard index >= 0, index < self.steps.count else { return }

                let step = self.steps[index]

                DatabaseManager.shared.update(step) {
                    step.photoData = image.jpegData(compressionQuality: 0.85)
                }

                self.reloadTable()
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
          //  onTextChanged?("")
        } else {
            ingredientsTextView.textColor = .color18181C
          //  onTextChanged?(trimmed)
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
