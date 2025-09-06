//
//  AdaptyManager.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import SwiftyStoreKit
import StoreKit

public enum AppProduct: String, Codable, CaseIterable {
    case monthTrial = "cooking_month_trial"
    case year = "cooking_year"
    
    static var allCaseRaws: [RawValue] {
        return Self.allCases.map({ $0.rawValue })
    }
}

public enum SubscriptionResponse {
    case success
    case error(SubscriptionError)
}

public enum SubscriptionError: Error {
    case nothingToRestore
    case failedToRestore
    case failedToPurchase
    case purchaseCancelled
    case failedToGetProductInfo
    case validateError
    case validateAnyActive
    case validateCustomerInfoNil
}

public class SubscriptionService: NSObject {

    public static let shared = SubscriptionService()

    private var products: [AppProduct : Subscription] = {
        let data = UserDefaults.standard.data(forKey: "productsSaveKey")
        let value = data.flatMap { try? JSONDecoder().decode([AppProduct : Subscription].self, from: $0) }
        return value ?? [:]

    }() {
        didSet {
            let data = try? JSONEncoder().encode(products)
            UserDefaults.standard.set(data, forKey: "productsSaveKey")
            UserDefaults.standard.synchronize()
        }
    }

    private let sharedSecret = "58d245b7bc1c4c17a6e92a4d2dc18dcc"

    private override init() {
        super.init()

        getAllProducts()
    }

    public func hasTrial(product: AppProduct) -> Bool {
        if let sub = getStoreProduct(from: product) {
            return sub.isTrial
        } else {
            return false
        }
    }
    public func configure() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
    }

    private func getAllProducts() {
        AppProduct.allCases.forEach { appProduct in
            Task {
                do {
                    let product = try await self.retrieveProductInfo(appProduct: appProduct)
                    self.setStoreProduct(product, for: appProduct)
                } catch {
                    print("❌ Failed to load \(appProduct):", error)
                }
            }
        }
    }


    public func validatePurchases() {
        var canceled:Bool = false

        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):

                let subs: [String] = AppProduct.allCases.map({$0.rawValue})

                for sub in subs {
                    switch SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable,
                        productId: sub,
                        inReceipt: receipt) {
                    case .purchased(_, _):
                     //   self.changePremium(state: true)
                        return
                    case .expired(_, _):
                        canceled = true
                    case .notPurchased:
                        canceled = true
                    }
                }

            case .error(let error):
                print("Receipt verification failed: \(error)")
            }

            if canceled == true {
             //   self.changePremium(state: false)
            }
        }
    }

    private func changePremium(state: Bool) {
        UserDefaults.premium = state
    }

    public func restorePurchase(completion: @escaping (SubscriptionResponse) -> Void) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                completion(.error(.failedToRestore))
            } else if results.restoredPurchases.count > 0 {
                completion(.success)
            } else {
                completion(.error(.nothingToRestore))
            }
        }
    }
    public func purchaseProduct(product: AppProduct, adaptyPlacement: AdaptyPlacement? = nil, completion: @escaping (SubscriptionResponse) -> Void) {
#if DEBUG
        completion(.success)
        return
#endif

        if let adaptyPlacement {
            if AdaptyService().hasProductForPaywall(placement: adaptyPlacement, id: product.rawValue) {
                AdaptyService().buyProduct(placement: adaptyPlacement, id: product.rawValue, completion: { result in
                    completion(result)
                })
                return
            }
        }
        SwiftyStoreKit.purchaseProduct("\(product.rawValue)", quantity: 1, atomically: true) { result in
            switch result {
            case .success(_):
                completion(.success)
            case .error(let error):
                switch error.code {
                case .paymentCancelled:
                    completion(.error(.purchaseCancelled))
                case .overlayCancelled:
                    completion(.error(.purchaseCancelled))
                default:
                    completion(.error(.failedToPurchase))
                }
            case .deferred(purchase: let purchase):
                completion(.error(.failedToPurchase))
            }
        }

    }

    public func retrieveProductInfo(appProduct: AppProduct) async throws -> Subscription {
            
            if let cached = getStoreProduct(from: appProduct) {
                return cached
            }
            
            let products = try await Product.products(for: [appProduct.rawValue])
            
            guard let product = products.first else {
                throw SubscriptionError.failedToGetProductInfo
            }
        
        let subscription = Subscription(
            id: product.id,
            localizedPrice: product.displayPrice,
            price: (product.price as NSDecimalNumber).doubleValue,
            currency: product.priceFormatStyle.currencyCode ?? "",
            isTrial: product.subscription?.introductoryOffer != nil,
            priceLocale: .current, // StoreKit2 пока не даёт Locale напрямую
            duration: .from(subscriptionPeriod: product.subscription?.subscriptionPeriod)
        )
        
            setStoreProduct(subscription, for: appProduct)
            
            return subscription
        }


    private func setStoreProduct(_ product: Subscription, for appProduct: AppProduct) {
        self.products[appProduct] = product
    }


    private func getStoreProduct(from appProduct: AppProduct) -> Subscription? {
        return products[appProduct]
    }
}
