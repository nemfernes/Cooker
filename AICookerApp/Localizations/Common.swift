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
        case aiCooking = "LS.Common.Strings.aiCooking"
        case myDishes = "LS.Common.Strings.myDishes"
        case settings = "LS.Common.Strings.settings"
        case allDishes = "LS.Common.Strings.allDishes"
        case soups = "LS.Common.Strings.soups"
        case salads = "LS.Common.Strings.salads"
        case mainCourses = "LS.Common.Strings.mainCourses"
        case breakfasts = "LS.Common.Strings.breakfasts"
        case appetizers = "LS.Common.Strings.appetizers"
        case desserts = "LS.Common.Strings.desserts"
        case drinks = "LS.Common.Strings.drinks"
        case urAIRecipe = "LS.Common.Strings.urAIRecipe"
        case selectCategory = "LS.Common.Strings.selectCategory"
        case generateRecipe = "LS.Common.Strings.generateRecipe"
        case contactUs = "LS.Common.Strings.contactUs"
        case shareApp = "LS.Common.Strings.shareApp"
        case settingTerms = "LS.Common.Strings.settingTerms"
        case settingPrivacy = "LS.Common.Strings.settingPrivacy"
        case restorePurchase = "LS.Common.Strings.restorePurchase"
        case noRecipts = "LS.Common.Strings.noRecipts"
        case addFirst = "LS.Common.Strings.addFirst"
        case addRecipt = "LS.Common.Strings.addRecipt"
        case editingRecept = "LS.Common.Strings.editingRecept"
        case createRecept = "LS.Common.Strings.createRecept"
        case name = "LS.Common.Strings.name"
        case pumpkinSoup = "LS.Common.Strings.pumpkinSoup"
        case photoFromGallery = "LS.Common.Strings.photoFromGallery"
        case takePhoto = "LS.Common.Strings.takePhoto"
        case ingredinets = "LS.Common.Strings.ingredinets"
        case pumpkin500 = "LS.Common.Strings.pumpkin500"
        case instructions = "LS.Common.Strings.instructions"
        case step = "LS.Common.Strings.step"
        case finelyChop = "LS.Common.Strings.finelyChop"
        case addStep = "LS.Common.Strings.addStep"
        case alert = "LS.Common.Strings.alert"
        case alertCancel = "LS.Common.Strings.alertCancel"
        case alertSettings = "LS.Common.Strings.alertSettings"
        case notFound = "LS.Common.Strings.notFound"
        case perhapsThis = "LS.Common.Strings.perhapsThis"
        case searchFor = "LS.Common.Strings.searchFor"
        case editRecept = "LS.Common.Strings.editRecept"
        case deleteRecipe = "LS.Common.Strings.deleteRecipe"
        case dataWill = "LS.Common.Strings.dataWill"
        case delete = "LS.Common.Strings.delete"
        case detail = "LS.Common.Strings.detail"
        case addToDishes = "LS.Common.Strings.addToDishes"
        case errorOccured = "LS.Common.Strings.errorOccured"
        case successAdded = "LS.Common.Strings.successAdded"

    }
}

extension Localizable where Self == LS.Common.Strings {
    public var tableName: String? { return "Localizable" }
}
