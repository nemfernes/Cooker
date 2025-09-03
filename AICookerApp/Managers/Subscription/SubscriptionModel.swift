import Foundation
import SwiftyStoreKit
import StoreKit

public struct Subscription: Codable {
    public var id: String
    public var localizedPrice: String
    public var price: Double
    public var currency: String
    public var isTrial: Bool
    
    /// Храним только идентификатор локали, чтобы корректно кодировать/декодировать
    private var localeIdentifier: String
    public var priceLocale: Locale {
        Locale(identifier: localeIdentifier)
    }
    
    public var duration: SubscriptionDuration

    // MARK: - Инициализаторы
    init(id: String,
         localizedPrice: String,
         price: Double,
         currency: String,
         isTrial: Bool,
         priceLocale: Locale,
         duration: SubscriptionDuration) {
        self.id = id
        self.localizedPrice = localizedPrice
        self.price = price
        self.currency = currency
        self.isTrial = isTrial
        self.localeIdentifier = priceLocale.identifier
        self.duration = duration
    }
    
    public init(duration: SubscriptionDuration? = nil) {
        self.id = "PRELOAD"
        self.localizedPrice = "_._$"
        self.price = 0
        self.currency = ""
        self.isTrial = false
        self.localeIdentifier = Locale.current.identifier
        self.duration = duration ?? .unknown
    }

    // MARK: - Форматирование цен
    private func formatPrice(_ value: Double, style: NumberFormatter.Style = .currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.locale = priceLocale
        return formatter.string(from: value as NSNumber) ?? "_._$"
    }
    
    public var priceForWeek: String {
        let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays()) * 7
        return formatPrice(price as NSDecimalNumber as! Double)
    }

    public var priceForDay: String {
        let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays())
        return formatPrice(price as NSDecimalNumber as! Double)
    }

    public var priceForMonth: String {
        let price = (NSDecimalNumber(value: price) as Decimal) / Decimal(duration.getDays()) * 30
        return formatPrice(price as NSDecimalNumber as! Double)
    }

    public var priceForX2Price: String {
        let price = (NSDecimalNumber(value: price) as Decimal) * 2
        return formatPrice(price as NSDecimalNumber as! Double)
    }

    public var priceWith45PercentDiscount: String {
        let currentPrice = price
        let originalPrice = currentPrice / (1 - 0.45)
        return formatPrice(roundToNearest99(originalPrice), style: .currencyAccounting)
    }

    public var priceWith60PercentDiscount: String {
        let currentPrice = price
        let originalPrice = currentPrice / (1 - 0.60)
        return formatPrice(roundToNearest99(originalPrice), style: .currencyAccounting)
    }

    // Дополнительная функция для округления к ближайшему 99
    private func roundToNearest99(_ value: Double) -> Double {
        return (value / 100.0).rounded() * 100.0 - 1.0
    }

    // MARK: - Вложенные типы
    public enum SubscriptionDuration: Codable {
        case year, month, week, halfYear, twoMonths, threeMonths, unknown

        public func getDays() -> Int {
            switch self {
            case .year: return 365
            case .month: return 30
            case .week: return 7
            case .halfYear: return 182
            case .twoMonths: return 60
            case .threeMonths: return 90
            case .unknown: return 1
            }
        }

        public func getDescriptionTitle() -> String {
            switch self {
            case .year: return "Year"
            case .month: return "Month"
            case .week: return "Week"
            case .halfYear: return "6 months"
            case .twoMonths: return "2 months"
            case .threeMonths: return "3 months"
            case .unknown: return "unknown"
            }
        }

        static func from(subscriptionPeriod: SKProductSubscriptionPeriod?) -> SubscriptionDuration {
            guard let subscriptionPeriod else { return .unknown }
            switch (subscriptionPeriod.unit, subscriptionPeriod.numberOfUnits) {
            case (.week, 1), (.day, 7): return .week
            case (.month, 1): return .month
            case (.month, 2): return .twoMonths
            case (.month, 3): return .threeMonths
            case (.month, 6): return .halfYear
            case (.year, 1): return .year
            default: return .unknown
            }
        }
    }
}

// MARK: - StoreKit2 support
extension Subscription.SubscriptionDuration {
    static func from(subscriptionPeriod: Product.SubscriptionPeriod?) -> Subscription.SubscriptionDuration {
        guard let subscriptionPeriod else { return .unknown }
        switch (subscriptionPeriod.unit, subscriptionPeriod.value) {
        case (.day, 7), (.week, 1): return .week
        case (.month, 1): return .month
        case (.month, 2): return .twoMonths
        case (.month, 3): return .threeMonths
        case (.month, 6): return .halfYear
        case (.year, 1): return .year
        default: return .unknown
        }
    }
}
