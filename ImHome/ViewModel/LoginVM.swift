//
//  LoginVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 08.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
import LocalAuthentication

class LoginVM: LoginViewModelType {
    
    private let keyChain: Keychain
    private let storageManager: StorageManager
    private let biometrick: BiometrickAuth
    private var login = ""
    private var password = ""
    private let nameAccount = "Home"
    
    init() {
        keyChain = Keychain()
        storageManager = StorageManager()
        biometrick = BiometrickAuth()
    }
    
    func getLogin() -> String {
        if let dict = keyChain.getKey(userAccount: nameAccount) {
            login = (dict["login"] as? String) ?? ""
        }
        return login
    }
    
    func getPassword() -> String {
        if let dict = keyChain.getKey(userAccount: nameAccount) {
            password = (dict["password"] as? String) ?? ""
        }
        return password
    }
    
    func setLoginPassword(login: String, password: String) {
        keyChain.addKey(data: ["login" : login, "password" : password], userAccount: nameAccount)
    }
    
    func showBiometrickAuth(context: LAContext, completion: @escaping (Bool) -> ()) {
        biometrick.showBiomentricAutorization(context: context) { (success) in
            completion(success)
        }
    }
    
    func getAccount() -> Account {
        return storageManager.getAccount()
    }
    
}
