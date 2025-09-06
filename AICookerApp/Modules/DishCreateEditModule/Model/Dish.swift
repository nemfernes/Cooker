//
//  Dish.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 04.09.2025.
//
import Kingfisher
import Foundation
import RealmSwift
import UIKit

class Dish: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var isAIGenerated: Bool = false

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

extension Dish {
    convenience init(from response: AIReceiptResponse, completion: (() -> Void)? = nil) {
        self.init()

        self.name = response.name
        self.ingredients = response.ingredients
        self.type = response.meta.category
        self.isAIGenerated = true

        let stepObjects = response.steps.map { text -> StepRealm in
            let step = StepRealm()
            step.text = text
            return step
        }
        self.steps.append(objectsIn: stepObjects)
        DatabaseManager.shared.add(self)

        let group = DispatchGroup()

        for urlString in response.images {
            guard let url = URL(string: urlString) else { continue }
            group.enter()

            ImageDownloader.default.downloadImage(with: url) { result in
                switch result {
                case .success(let value):
                    if let data = value.image.jpegData(compressionQuality: 0.85) {
                        DatabaseManager.shared.update(self) {
                            self.photos.append(data)
                        }
                    }
                case .failure(let error):
                    print("❌ Ошибка загрузки картинки: \(error)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion?()
        }
    }
}
