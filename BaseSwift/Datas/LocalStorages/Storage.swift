//
//  Storage.swift
//  gurume_go_ios
//
//  Created by daovu on 04/07/2022.
//

import Foundation
import KeychainAccess

struct AppData {
    
    @Storage(defaultValue: false)
    static var enableAutoLogin: Bool
    
    @Storage(defaultValue: true)
    static var firstLogin: Bool
    
    @Storage(defaultValue: "")
    static var token: String
    
    @AppKeychain(defaultValue: nil)
    static var device_id: String?
    
}

@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    private let defaults = UserDefaults.standard
    
    init(key: String = #function, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return defaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            defaults.set(newValue, forKey: key)
            defaults.synchronize()
        }
    }
}

@propertyWrapper
struct AppKeychain<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")
    
    init(key: String = #function, defaultValue: T? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            guard let data = keychain[data: key] else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            if newValue == nil {
                try? keychain.remove(key)
            } else {
                let data = try? JSONEncoder().encode(newValue)
                keychain[data: key] = data
            }
        }
    }
}
