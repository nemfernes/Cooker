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
        setupHideKeyboardGesture()
    }

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
    
    private func setupHideKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
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
