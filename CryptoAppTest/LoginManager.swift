//
//  LoginManager.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import Foundation

final class LoginManager {
    
    static let shared = LoginManager()
    
    private init() {}
    
    private let password = "1234"
    private let userName = "1234"
    
    private let defaults = UserDefaults.standard
    
    func login(with userName: String, and password: String) -> Bool {
        if password == self.password && userName == self.userName {
            saveState(state: true)
            return true
        } else {
            return false
        }
    }
    
    func unlog() {
        saveState(state: false)
    }
    
    private func saveState(state: Bool) {
        defaults.set(state, forKey: "isLogin")
    }
    
    func checkIfAuthorised() -> Bool {
        return defaults.bool(forKey: "isLogin")
    }
}
