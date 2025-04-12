//
//  LoginVM.swift
//  CryptoAppTest
//
//  Created by Руслан Усманов on 12.04.2025.
//

import Foundation

final class LoginVM {

    func checkPassword(userName: String, password: String) -> Bool {
        LoginManager.shared.login(with: userName, and: password)
    }
}
