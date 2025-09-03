//
//  Common.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation

import Foundation

public extension LS {
    enum Common {}
}

public extension LS.Common {
    enum Strings: String, Localizable {
        case continueButton = "LS.Common.Strings.continue"
        case saveRecept = "LS.Common.Strings.saveRecept"
        case keepFav = "LS.Common.Strings.keepFav"
        case generateIdeas = "LS.Common.Strings.generateIdeas"
        case useAI = "LS.Common.Strings.useAI"
        case exploreEasily = "LS.Common.Strings.exploreEasily"
        case browseBy = "LS.Common.Strings.browseBy"
        case unlockAccess = "LS.Common.Strings.unlockAccess"
        case enjoyUnlim = "LS.Common.Strings.enjoyUnlim"
        case day3Trial = "LS.Common.Strings.day3Trial"
        case year = "LS.Common.Strings.year"
        case thenPerWeek = "LS.Common.Strings.thenPerWeek"
        case monthly = "LS.Common.Strings.monthly"
        case noPaymnet = "LS.Common.Strings.noPaymnet"
        case startTrial = "LS.Common.Strings.startTrial"
        case terms = "LS.Common.Strings.terms"
        case restore = "LS.Common.Strings.restore"
        case privacy = "LS.Common.Strings.privacy"
        case cancelAnytime = "LS.Common.Strings.cancelAnytime"

    }
}

extension Localizable where Self == LS.Common.Strings {
    public var tableName: String? { return "Localizable" }
}
