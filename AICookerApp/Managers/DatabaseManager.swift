//
//  DatabaseManager.swift
//  AICookerApp
//
//  Created by Dmitry Kirpichev on 03.09.2025.
//

import Foundation

import RealmSwift

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("❌ Failed to open Realm: \(error)")
        }
    }
    
    private init() {}
    
    // MARK: - Create
    
    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("❌ Error adding object: \(error)")
        }
    }
    
    func addMany<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            print("❌ Error adding objects: \(error)")
        }
    }
    
    // MARK: - Read
    
    func getAll<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    func getById<T: Object, KeyType>(_ type: T.Type, key: KeyType) -> T? {
        return realm.object(ofType: type, forPrimaryKey: key)
    }
    
    // MARK: - Update
    
    func update<T: Object>(_ object: T, with updates: () -> Void) {
        if let r = object.realm {
            do { try r.write { updates() } }
            catch { print("❌ Error updating object: \(error)") }
        } else {
            updates()
        }
    }
    
    func updateField<T: Object>(_ object: T, keyPath: ReferenceWritableKeyPath<T, String>, value: String) {
        do {
            try realm.write {
                object[keyPath: keyPath] = value
            }
        } catch {
            print("❌ Error updating field: \(error)")
        }
    }
    
    // MARK: - Delete
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("❌ Error deleting object: \(error)")
        }
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
           do {
               try realm.write {
                   let all = realm.objects(type)
                   realm.delete(all)
               }
           } catch {
               print("❌ Error deleting all objects: \(error)")
           }
       }
   }
