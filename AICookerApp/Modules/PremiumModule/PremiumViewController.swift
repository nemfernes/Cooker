//
//  OnboardingViewController.swift
//  CookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import UIKit
import SafariServices

protocol PremiumViewControllerDelegate: AnyObject {
    func premiumViewControllerDidClose(_ controller: PremiumViewController)
}

public enum PremiumButtonType {
    case month, year
}

class PremiumViewController: BaseViewController {
    
    
    @IBOutlet weak var bottomContainerView: UIView!{
        didSet {
            bottomContainerView.backgroundColor = .white
            bottomContainerView.layer.cornerRadius = 16
            bottomContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel!   {
        didSet {
            subTitleLabel.textColor = UIColor.asset(.color_18181C)
            subTitleLabel.text = LS.Common.Strings.enjoyUnlim.localized
            subTitleLabel.font = .sfMedium20
            subTitleLabel.numberOfLines = 4
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!   {
        didSet {
            titleLabel.textColor = UIColor.asset(.color_18181C)
            titleLabel.text = LS.Common.Strings.unlockAccess.localized
            titleLabel.font = .sfMedium30
            titleLabel.numberOfLines = 2
        }
    }

    @IBOutlet weak var titleImageView: UIImageView! {
        didSet {
            titleImageView.image = UIImage.asset(.premiumTitleImage)
        }
    }
    
    @IBOutlet weak var yearlyCheckboxImageView: UIImageView!
    @IBOutlet weak var yearlyContainerView: UIView!  {
        didSet {
            yearlyContainerView.backgroundColor = .white
            yearlyContainerView.layer.cornerRadius = 16
            yearlyContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var yearlyTitleLabel: UILabel!   {
        didSet {
            yearlyTitleLabel.text = LS.Common.Strings.year.localized
            yearlyTitleLabel.textColor = UIColor.asset(.color_18181C)
            yearlyTitleLabel.font = .sfMedium16
        }
    }
    @IBOutlet weak var yearlySubtitleLabel: UILabel!  {
        didSet {
            yearlySubtitleLabel.textColor = UIColor.asset(.color_82828E)
            yearlySubtitleLabel.font = .sfMedium14
        }
    }
    
    
    @IBOutlet weak var monthTrialView: UIView!  {
        didSet {
            monthTrialView.backgroundColor = UIColor.asset(.color_71B94D)
        }
    }
    @IBOutlet weak var monthTrialLabel: UILabel!  {
        didSet {
            monthTrialLabel.textColor = .white
            monthTrialLabel.font = .sfRegular16
            monthTrialLabel.text = LS.Common.Strings.day3Trial.localized
        }
    }
    
    @IBOutlet weak var monthCheckboxImageView: UIImageView!
    @IBOutlet weak var monthContainerView: UIView!  {
        didSet {
            monthContainerView.backgroundColor = .white
            monthContainerView.layer.cornerRadius = 16
            monthContainerView.clipsToBounds = true
        }
    }
    @IBOutlet weak var monthTitleLabel: UILabel!  {
        didSet {
            monthTitleLabel.text = LS.Common.Strings.monthly.localized
            monthTitleLabel.textColor = UIColor.asset(.color_18181C)
            monthTitleLabel.font = .sfMedium16
        }
    }
    @IBOutlet weak var monthSubtitleLabel: UILabel!   {
        didSet {
            monthSubtitleLabel.textColor = UIColor.asset(.color_82828E)
            monthSubtitleLabel.font = .sfMedium14
        }
    }
    
    @IBOutlet weak var yearlyButton: UIButton!   {
        didSet {
            yearlyButton.addTarget(self, action: #selector(yearTapped), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var monthButton: UIButton!  {
        didSet {
            monthButton.addTarget(self, action: #selector(monthTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.setTitle(LS.Common.Strings.continueButton.localized.uppercased(), for: .normal)
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.titleLabel?.font = .sfSemiBold16
            continueButton.backgroundColor = UIColor.asset(.color_1E1E1E)
            continueButton.layer.cornerRadius = 28
            continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var statusLabel: UILabel!  {
        didSet {
            statusLabel.textColor = UIColor.asset(.color_82828E)
            statusLabel.font = .sfMedium12
        }
    }
    
    @IBOutlet weak var privacyButton: UIButton!  {
        didSet {
            privacyButton.setAttributedTitle("Privacy".getUnderline(), for: .normal)
            privacyButton.setTitleColor(UIColor.asset(.color_82828E), for: .normal)
            privacyButton.titleLabel?.font = .sfMedium12
            privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var termsButton: UIButton!  {
        didSet {
            termsButton.setAttributedTitle("Terms".getUnderline(), for: .normal)
            termsButton.setTitleColor(UIColor.asset(.color_82828E), for: .normal)
            termsButton.titleLabel?.font = .sfMedium12
            termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var restoreButton: UIButton!  {
        didSet {
            restoreButton.setAttributedTitle("Restore".getUnderline(), for: .normal)
            restoreButton.setTitleColor(UIColor.asset(.color_82828E), for: .normal)
            restoreButton.titleLabel?.font = .sfMedium12
            restoreButton.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
        }
    }
    let placement: AdaptyPlacement
    var router: PremiumRouterProtocol?
    weak var delegate: PremiumViewControllerDelegate?
    
    private var yearSubscription: AppProduct = .year
    private var monthSubscription: AppProduct = .monthTrial
    private var currentProduct: PremiumButtonType = .month

    
    init(placement: AdaptyPlacement) {
        self.placement = placement
        super.init(nibName: "PremiumViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrice()
        setupUI(product: .month)
    }

    
    @objc private func continueTapped(_ sender: UIButton) {
        self.purchase(sub: self.currentProduct)
    }
    
    @objc private func restoreTapped(_ sender: UIButton) {
        self.restore()
    }
    
    @objc private func termsTapped(_ sender: UIButton) {
        router?.openLink("https://doc-hosting.flycricket.io/ai-cooking-receipts-terms-of-use/0fbca682-7a53-4310-8c8d-c80867261c69/terms")
    }
    
    @objc private func privacyTapped(_ sender: UIButton) {
        router?.openLink("https://doc-hosting.flycricket.io/ai-cooking-receipts-privacy-policy/54064618-5f79-4424-9344-5395a797b576/privacy")
    }
    
    @objc private func monthTapped(_ sender: UIButton) {
        currentProduct = .month
        setupUI(product: .month)
    }
    
    @objc private func yearTapped(_ sender: UIButton) {
        currentProduct = .year
        setupUI(product: .year)
    }
    
    func setupUI(product: PremiumButtonType) {
        switch product {
        case .month:
            statusLabel.text = LS.Common.Strings.noPaymnet.localized
            monthTrialView.backgroundColor = UIColor.asset(.color_71B94D)
            monthContainerView.layer.borderColor = UIColor.asset(.color_71B94D).cgColor
            monthContainerView.layer.borderWidth = 1
            monthCheckboxImageView.image = UIImage.asset(.checkboxFilledIcon)
            
            yearlyContainerView.layer.borderWidth = 0
            yearlyCheckboxImageView.image = UIImage.asset(.checkboxEmptyIcon)
        case .year:
            statusLabel.text = LS.Common.Strings.cancelAnytime.localized
            yearlyContainerView.layer.borderWidth = 1
            yearlyContainerView.layer.borderColor = UIColor.asset(.color_71B94D).cgColor
            yearlyCheckboxImageView.image = UIImage.asset(.checkboxFilledIcon)
            
            monthTrialView.backgroundColor = UIColor.asset(.color_1E1E1E)
            monthContainerView.layer.borderWidth = 0
            monthCheckboxImageView.image = UIImage.asset(.checkboxEmptyIcon)
        }
    }
    
    func setPrice(product: PremiumButtonType, sub: Subscription) {
        switch product {
        case .month:
            monthSubtitleLabel.text = String(format: LS.Common.Strings.thenPerWeek.localized, sub.localizedPrice)
        case .year:
            yearlySubtitleLabel.text = sub.localizedPrice
        }
    }
    
    private func setupPrice() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let monthResult = try await SubscriptionService.shared.retrieveProductInfo(appProduct: monthSubscription)
                self.setPrice(product: .month, sub: monthResult)

                let yearResult = try await SubscriptionService.shared.retrieveProductInfo(appProduct: yearSubscription)
                self.setPrice(product: .year, sub: yearResult)
            } catch {
                print("❌ setupPrice error:", error)
            }
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
    
    private func purchase(sub: PremiumButtonType) {
        addLoadingView()
        let product: AppProduct
        switch sub {
        case .month:
            product = monthSubscription
        case .year:
            product = yearSubscription
        }
        SubscriptionService.shared.purchaseProduct(product: product, adaptyPlacement: placement, completion: { [weak self] result in
            guard let self else { return }
            removeLoadingView()
            switch result {
            case .success:
                UserDefaults.premium = true
                self.delegate?.premiumViewControllerDidClose(self)
                self.router?.close()
            case .error(_):
                break
            }
        })
    }

}
