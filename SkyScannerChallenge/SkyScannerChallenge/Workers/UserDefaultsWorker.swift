//
//  UserDefaultsWorker.swift
//  SkyScannerChallenge
//
//  Created by iOS developer on 12/11/18.
//  Copyright © 2018 Sky Scanner Candidate Ltd. All rights reserved.
//

import Foundation

struct UserDefaultsWorker {
    let userDefaults = UserDefaults.standard

    // MARK: - User logged state

    func changeUserLoggedState(_ state: Bool) {
        saveObject(state, key: .userLoggedStateKey)
    }

    func removeUserLoggedState() {
        return removeObject(.userLoggedStateKey)
    }

    func isUserLoggedIn() -> Bool {
        return getObject(.userLoggedStateKey) as? Bool ?? false
    }
}

private extension UserDefaultsWorker {
    // MARK: - Base user Defaults
    func saveObject(_ object: Any, key: Constant.UserDefaultsKey) {
        userDefaults.set(object, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func getObject(_ key: Constant.UserDefaultsKey) -> Any? {
        return userDefaults.object(forKey: key.rawValue) as Any?
    }

    func removeObject(_ key: Constant.UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
