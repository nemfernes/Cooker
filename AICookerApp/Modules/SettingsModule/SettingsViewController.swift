//
//  SettingsViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 02.09.2025.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = LS.Common.Strings.settings.localized
            titleLabel.textColor = .color18181C
            titleLabel.font = .sfMedium16
        }
    }
    @IBOutlet weak var bottomStackView: UIStackView! {
        didSet {
            bottomStackView.layer.cornerRadius = 16
            bottomStackView.clipsToBounds = true
        }
    }
    @IBOutlet weak var topStackView: UIStackView!  {
        didSet {
            topStackView.layer.cornerRadius = 16
            topStackView.clipsToBounds = true
        }
    }
    @IBOutlet weak var contactView: SettingView!  {
        didSet {
            contactView.setup(title: LS.Common.Strings.contactUs.localized, image: .mailIcon)
        }
    }
    @IBOutlet weak var shareView: SettingView!  {
        didSet {
            shareView.setup(title: LS.Common.Strings.shareApp.localized, image: .shareIcon)
        }
    }
    
    @IBOutlet weak var termsView: SettingView!  {
        didSet {
            termsView.setup(title: LS.Common.Strings.settingTerms.localized, image: .termsIcon)
        }
    }
    
    @IBOutlet weak var restoreView: SettingView!  {
        didSet {
            restoreView.setup(title: LS.Common.Strings.restorePurchase.localized, image: .restoreIcon)
        }
    }
    @IBOutlet weak var privacyView: SettingView!  {
        didSet {
            privacyView.setup(title: LS.Common.Strings.settingPrivacy.localized, image: .privacyIcon)
        }
    }
    
    var router: SettingsRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActions()
    }
    
    func setupActions() {
           contactView.pressAction = { [weak self] in
               guard let self else {return}
               self.router?.sendEmail()
           }
           shareView.pressAction   = { [weak self] in
               guard let self else {return}
               if let url = URL(string: "https://apps.apple.com/us/app/id1524444444") {
                       self.router?.shareLink(url)
                   }
           }
           termsView.pressAction   = { [weak self] in
               guard let self else {return}
               self.router?.openLink("https://doc-hosting.flycricket.io/ai-cooking-receipts-terms-of-use/0fbca682-7a53-4310-8c8d-c80867261c69/terms")
               }
           restoreView.pressAction = { [weak self] in
               guard let self else {return}
               self.restore()
           }
           privacyView.pressAction = { [weak self] in
               guard let self else {return}
               self.router?.openLink("https://doc-hosting.flycricket.io/ai-cooking-receipts-privacy-policy/54064618-5f79-4424-9344-5395a797b576/privacy")
               }
    }
    
    private func restore() {
        addLoadingView()
        SubscriptionService.shared.restorePurchase(completion: { [weak self] result in
            guard let self else { return }
            removeLoadingView()
            switch result {
            case .success:
                UserDefaults.premium = true
            case .error(_):
                break
            }
        })
    }
}
