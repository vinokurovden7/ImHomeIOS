//
//  LoginViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 08.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol LoginViewModelType {
    func getLogin() -> String
    func getPassword() -> String
    func setLoginPassword(login: String, password: String)
    func showBiometrickAuth(context: LAContext, completion: @escaping (Bool) -> ())
    func getAccount() -> Account
}
