//
//  UserDefaults.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation

extension UserDefaults {
    private static let adaptyUserIdKey = "adapty_user_id"

    static var adaptyUserId: String {
        if let id = standard.string(forKey: adaptyUserIdKey) {
            return id
        } else {
            let newId = UUID().uuidString
            standard.set(newId, forKey: adaptyUserIdKey)
            return newId
        }
    }
    
    public static var premium: Bool {
        get {
            UserDefaults.standard.bool(forKey: "premiumKey")
        }
        set {
            guard UserDefaults.standard.bool(forKey: "premiumKey") != newValue else { return }
            UserDefaults.standard.set(newValue, forKey: "premiumKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    public static var showMain: Bool {
        get {
            UserDefaults.standard.bool(forKey: "premiumKey")
        }
        set {
            guard UserDefaults.standard.bool(forKey: "premiumKey") != newValue else { return }
            UserDefaults.standard.set(newValue, forKey: "premiumKey")
            UserDefaults.standard.synchronize()
        }
    }
}
