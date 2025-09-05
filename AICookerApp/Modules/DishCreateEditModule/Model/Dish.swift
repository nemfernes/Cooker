//
//  Dish.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//

import Foundation
import RealmSwift
import UIKit

class Dish: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    
    @objc dynamic var ingredients: String = ""
    let steps = List<StepRealm>()
    let photos = List<Data>()
    
    var images: [UIImage] {
            photos.compactMap { UIImage(data: $0) }
        }
    
    override static func primaryKey() -> String? { "id" }
}

class StepRealm: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var photoData: Data? = nil
    var image: UIImage? {
            get { photoData.flatMap { UIImage(data: $0) } }
            set { photoData = newValue?.jpegData(compressionQuality: 0.85) }
        }
}

