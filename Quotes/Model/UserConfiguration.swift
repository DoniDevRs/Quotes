//
//  UserConfiguration.swift
//  QuotesApp
//
//  Created by Doni Silva on 24/08/24.
//

import Foundation

enum UserDefatulsKeys: String {
    case timeInterval = "timeInterval"
    case colorScheme = "colorScheme"
    case autoRefresh = "autoRefresh"
}

public class UserConfiguration {
    
    static let shared: UserConfiguration = UserConfiguration()
    
    let defaults = UserDefaults.standard
    
    var timeInterval: Double {
        get {
            return defaults.double(forKey: UserDefatulsKeys.timeInterval.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefatulsKeys.timeInterval.rawValue)
        }
    }
    
    var colorScheme: Int {
        get {
            return defaults.integer(forKey: UserDefatulsKeys.colorScheme.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefatulsKeys.colorScheme.rawValue)
        }
    }
    
    var autoRefresh: Bool{
        get {
            return defaults.bool(forKey: UserDefatulsKeys.autoRefresh.rawValue)
        }
        set {
            defaults.set(newValue, forKey: UserDefatulsKeys.autoRefresh.rawValue)
        }
    }
    
    private init() {
        if defaults.double(forKey: UserDefatulsKeys.timeInterval.rawValue) == 0 {
            defaults.set(8.0, forKey: UserDefatulsKeys.timeInterval.rawValue)
        }
    }
}
