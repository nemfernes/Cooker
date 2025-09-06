//
//  DishResponse.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 06.09.2025.
//

import Foundation

struct AIReceiptResponse: Decodable {
    let name: String
    let ingredients: String
    let steps: [String]
    let images: [String]
    let meta: Meta
    
    struct Meta: Decodable {
        let category: String
        let locale: String
        let model: String
        let user_id: String
        let unsplash_app_id: String
    }
}
