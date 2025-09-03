//
//  AdaptyService.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import Adapty
import AdaptyUI

public class AdaptyService {
    internal static let shared = AdaptyService()

    private var paywalls: [AdaptyPlacement : AdaptyPaywall] = [:]

    private var paywallsController: [AdaptyPlacement : AdaptyPaywall] = [:]

    private var products: [AdaptyPlacement : [AdaptyPaywallProduct]] = [:]

    public func configure() {
        Adapty.activate("public_live_WpWenzmD.XfnERx39FQxgI8EYDVtK", { error in
            for value in AdaptyPlacement.allCases {
                Adapty.getPaywall(placementId: value.key, { result in
                    switch result {
                    case .success(let paywall):
                        self.paywalls[value] = paywall
                        print("ADATY Placement \(value.key)", paywall.remoteConfig)
                        self.fetchProductsForPaywall(placement: value)
                    case .failure(let error):
                        break
                    }
                })
            }
        })
    }

    private func fetchProductsForPaywall(placement: AdaptyPlacement) {
        if let paywall = paywalls[placement] {
            Adapty.getPaywallProducts(paywall: paywall, { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let p):
                    self.products[placement] = p
                case .failure(_):
                    break
                }
            })
        }
    }

    public func hasPaywall(placement: AdaptyPlacement) -> Bool {
        return paywalls[placement] != nil
    }

    public func hasProductForPaywall(placement: AdaptyPlacement, id: String) -> Bool {
        return products[placement]?.contains(where: {$0.vendorProductId == id}) ?? false
    }
    public func getAbValue(placement: AdaptyPlacement) -> Int? {
        if let id = paywalls[placement]?.remoteConfig?.dictionary?["id"] as? Int {
            return id
        }
        return nil
    }
    
    public func logPaywallOpen(placement: AdaptyPlacement) {
        if let paywall = paywalls[placement] {
            Adapty.logShowPaywall(paywall)
        }
    }

    public func buyProduct(placement: AdaptyPlacement, id: String, completion: ((SubscriptionResponse) -> Void)?) {
        if let product = products[placement]?.first(where: { $0.vendorProductId == id }) {
            Adapty.makePurchase(product: product) { result in
                switch result {
                case let .success(info):
                    completion?(.success)
                case let .failure(error):
                    print(error.localizedDescription, "Adapty error")

                    switch error.adaptyErrorCode {
                    case .paymentCancelled:
                        completion?(.error(.purchaseCancelled))
                    default:
                        completion?(.error(.failedToPurchase))
                    }
                    break
                }
            }
        } else {
            completion?(.error(.failedToPurchase))
        }
    }

}

public enum AdaptyPlacement: CaseIterable {
    case main, onboarding

    var key: String {
        var isProd: Bool = Bundle.main.appStoreReceiptURL?.lastPathComponent != "sandboxReceipt"
            switch self {
            case .onboarding:
                return "onboarding"
            case .main:
                return "main"
            }
    }
}
