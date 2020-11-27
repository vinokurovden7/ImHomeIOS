//
//  ProfileViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 26.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol ProfileViewModelType {
    func buttonSetup(button: UIButton)
    func textFieldSetup(textField: UITextField)
    func showPasswordManagerAction()
    func deleteAccount()
    func saveAccount(account: Account)
    func changeLocalPass()
    func changeAccountPass()
    func getPhotoAccount() -> UIImage
    func getFioAccount() -> String
    func getEmailAccount() -> String
    func getFirstName() -> String
    func getSecondName() -> String
    func getThirdName() -> String
    func getTimeCancelSosSignal() -> String
}
