//
//  OnboardingNodel.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 01.09.2025.
//

import Foundation
import UIKit

struct OnboardingModel {
    let title: String
    let subtitle: String
    let image: UIImage
    let pageImage: UIImage
}

struct OnboardingData {
    static let data: [OnboardingModel] = [
        OnboardingModel(title: LS.Common.Strings.saveRecept.localized, subtitle:  LS.Common.Strings.keepFav.localized, image: UIImage.asset(.onboarding1Image), pageImage: .pagination1),
        OnboardingModel(title: LS.Common.Strings.generateIdeas.localized, subtitle:  LS.Common.Strings.useAI.localized, image: UIImage.asset(.onboarding2Image), pageImage: .pagination2),
        OnboardingModel(title: LS.Common.Strings.exploreEasily.localized, subtitle:  LS.Common.Strings.browseBy.localized, image: UIImage.asset(.onboarding3Image), pageImage: .pagination3)
            ]
}
