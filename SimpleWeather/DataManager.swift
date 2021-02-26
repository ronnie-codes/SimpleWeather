//
//  DataManager.swift
//  SimpleWeather
//
//  Created by Neutral Magnet on 2/25/21.
//

import Foundation
import CoreData
import Apollo

enum DataKey: String {
    case cities
}

final class DataManager: NSObject {
    static let shared = DataManager()
    
    private let db = UserDefaults.standard
    
    private override init() {
        super.init()
    }
    
    func add(value: String, forKey: DataKey) {
        var store = db.stringArray(forKey: forKey.rawValue) ?? []
        store.append(value)
        db.set(store, forKey: forKey.rawValue)
    }
    
    func remove(value: String, forKey: DataKey) {
        let store: [String] = (db.stringArray(forKey: forKey.rawValue) ?? []).filter { $0 != value }
        db.set(store, forKey: forKey.rawValue)
    }
    
    func fetchAll(forKey: DataKey) -> [String] {
        return db.stringArray(forKey: forKey.rawValue) ?? []
    }
    
    func checkIfExists(value: String, forKey: DataKey) -> Bool {
        let store: [String] = (db.stringArray(forKey: forKey.rawValue) ?? []).filter { $0 == value }
        return !store.isEmpty
    }
}
