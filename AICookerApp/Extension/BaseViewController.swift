//
//  BaseViewController.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

public enum AnimationEnum {
    case indicator, none
}

open class BaseViewController: UIViewController {
    // MARK: - Properties
    
    private var loadingTimer: Timer = Timer()
    private var loadingView: UIView! {
        didSet {
            loadingTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(addLoadingTapGesture), userInfo: nil, repeats: false)
        }
    }
    open var premium: Bool = false
    
    // MARK: - View lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        premium = UserDefaults.premium
        premiumDidChange()
    }
    
    @objc private func handleOfflineChange() {
        offlineDidChange()
    }
        
    open func offlineDidChange() {}

    @objc private func handlePremiumChange() {
        let newValue = UserDefaults.premium
        if (premium != newValue) {
            premium = newValue
            premiumDidChange()
        }
    }
    @objc private func handleLangChange() {
        languageDidChange()
    }
        
    open func languageDidChange() {}

    @objc private func handleTranslateTypeChange(notification: Notification) {
        if let needTranslate = notification.userInfo?["withTranslate"] as? Bool {
            translateTypeDidChange(needTranslate: needTranslate)
            return
        }
        translateTypeDidChange(needTranslate: false)
    }
        
    open func translateTypeDidChange(needTranslate: Bool) {}

    open func premiumDidChange() {}
        
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: - Public methods
    public func isLoading() -> Bool {
        guard loadingView != nil else { return false }
        return loadingView.superview != nil
    }
   
    open func addLoadingView(with animation: AnimationEnum = .indicator) {
        removeLoadingView()
        loadingView = UIView()
        loadingView.backgroundColor = .black.withAlphaComponent(0.8)
        switch animation {
        case .indicator:
            let indicator = UIActivityIndicatorView()
            if #available(iOS 13.0, *) {
                indicator.style = .large
            } else {
                indicator.style = .whiteLarge
            }
            indicator.color = .white
            loadingView.addSubview(indicator)
            indicator.startAnimating()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            //loadingView.addSubview(indicator)
            indicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: 0).isActive = true
            indicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor, constant: 0).isActive = true
        case .none:
            loadingView.backgroundColor = .black
        }
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    open func removeLoadingView() {
        if let view = loadingView {
            loadingTimer.invalidate()
            DispatchQueue.main.async {
                view.removeFromSuperview()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - Public
internal extension BaseViewController {
    // MARK: - Actions
    
    @objc private func addLoadingTapGesture() {
        if let view = loadingView {
            loadingTimer.invalidate()
            let tapsGesture = UITapGestureRecognizer(target: self, action: #selector(loadingGestureHandler(_:)))
            tapsGesture.numberOfTapsRequired = 3
            view.addGestureRecognizer(tapsGesture)
        }
    }
    
    @objc private func loadingGestureHandler(_ gesture: UITapGestureRecognizer) {
        guard (gesture.view) != nil else {
            return
        }
        loadingView?.gestureRecognizers?.removeAll()
        removeLoadingView()
    }
}
