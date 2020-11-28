//
//  ProfileVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 26.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
class ProfileVM: ProfileViewModelType {
    
    let viewController: UIViewController
    private let keychain = Keychain()
    private let storageManager = StorageManager()
    private var sourceType: UIImagePickerController.SourceType?
    private lazy var account = Account()
    private lazy var changedOldLocalPassTF = UITextField()
    private lazy var changedNewLocalPassTF = UITextField()
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// Изменение пароля аккаунта
    func changeAccountPass() {
        let alert = UIAlertController(title: "Пароль аккаунта", message: "Смена пароля", preferredStyle: .alert)
        alert.addTextField { (oldPassTF) in
            oldPassTF.placeholder = "Старый пароль"
            
        }
        alert.addTextField { (newPassTF) in
            newPassTF.placeholder = "Новый пароль"
        }
        alert.addTextField { (confirmNewPassTF) in
            confirmNewPassTF.placeholder = "Повторите новый пароль"
        }
        let changePassAction = UIAlertAction(title: "Сменить пароль", style: .default, handler: { _ in
            guard let oldPassTF = alert.textFields?[0] else {return}
            guard let newPassTF = alert.textFields?[1] else {return}
            guard let confirmNewPassTF = alert.textFields?[2] else {return}
            
            if oldPassTF.text!.isEmpty || newPassTF.text!.isEmpty || confirmNewPassTF.text!.isEmpty {
                print("Заполните все поля!")
                return
            }
        })
        alert.addAction(changePassAction)
        viewController.present(alert, animated: true)
    }
    
    /// Изменеие локального пароля для отмены вызова помощи
    func changeLocalPass() {
        let alert = UIAlertController (title: "Локальный пароль", message: "Смена пароля", preferredStyle: .alert)
        alert.addTextField { [self] (oldLocalPass) in
            oldLocalPass.placeholder = "Старый пароль"
            oldLocalPass.keyboardType = .numberPad
            oldLocalPass.isSecureTextEntry = true
            changedOldLocalPassTF = oldLocalPass
        }
        alert.addTextField { [self] (newLocalPass) in
            newLocalPass.placeholder = "Новый пароль"
            newLocalPass.keyboardType = .numberPad
            newLocalPass.isSecureTextEntry = true
            changedNewLocalPassTF = newLocalPass
        }
        let changeLocalPassAction = UIAlertAction(title: "Сменить пароль", style: .default, handler: { _ in
            guard let oldLocalPass = alert.textFields?[0] else {return}
            guard let newLocalPass = alert.textFields?[1] else {return}
            
            if oldLocalPass.text!.isEmpty || newLocalPass.text!.isEmpty {
                print("Заполните все поля!")
            }
        })
        alert.addAction(changeLocalPassAction)
        viewController.present(alert, animated: true)
    }
    
    //MARK: Ограничение на ввод больше 2 цифр
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (Int(string) ?? 0 > 0 && changedOldLocalPassTF.text?.count ?? 0 > 0 && Int(changedOldLocalPassTF.text!) ?? 0 >= 7) || (Int(string) ?? 0 > 0 && changedNewLocalPassTF.text?.count ?? 0 > 0 && Int(changedNewLocalPassTF.text!) ?? 0 >= 7) {
        }
        if range.length + range.location > (changedOldLocalPassTF.text?.count)! {return false}
        let newLimit = (changedOldLocalPassTF.text?.count)! + string.count - range.length
        return newLimit <= 6
    }
    
    /// Настройка кнопки
    /// - Parameter button: кнопка, к которой применяется настройка
    func buttonSetup(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    /// Настройка полей
    /// - Parameter textField: поле, к которому применяется настройка
    func textFieldSetup(textField: UITextField) {
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.clipsToBounds = true
    }
    
    /// Показ менеджера паролей
    func showPasswordManagerAction() {
        let lockShieldIcon = UIImage.init(systemName: "lock.shield")
        let lockIcon = UIImage.init(systemName: "lock")
        
        let passwordActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let changePassAccount = UIAlertAction(title: "Сменить пароль", style: .default) { _ in
            self.changeAccountPass()
        }
        changePassAccount.setValue(lockShieldIcon, forKey: "image")
        changePassAccount.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let changeLocalPass = UIAlertAction(title: "Сменить локальный пароль", style: .default) { _ in
            self.changeLocalPass()
        }
        changeLocalPass.setValue(lockIcon, forKey: "image")
        changeLocalPass.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        passwordActionSheet.addAction(changePassAccount)
        passwordActionSheet.addAction(changeLocalPass)
        passwordActionSheet.addAction(cancel)
        viewController.present(passwordActionSheet, animated: true)
    }
    
    /// Удаление аккаунта
    func deleteAccount() {
        keychain.removeKey(userAccount: "Home")
        storageManager.deleteAccount()
    }
    
    /// Сохранение аккаунта
    /// - Parameter account: аккаунт для сохранения
    func saveAccount(account: Account) {
        account.idAccount = storageManager.getAccount().idAccount
        account.timeCancelSosSignal = storageManager.getAccount().timeCancelSosSignal
        account.useBiometrick = storageManager.getAccount().useBiometrick
        storageManager.saveAccount(account: account)
    }
    
    func getPhotoAccount() -> UIImage {
        account = storageManager.getAccount()
        return UIImage(data: (account.photoAccount ?? UIImage(named: "camera")?.pngData())!)!
    }
    
    func getFioAccount() -> String {
        account = storageManager.getAccount()
        return "\(account.secondNameAccount) \(account.firstNameAccount) \(account.thirdNameAccount ?? "")"
    }
    
    func getEmailAccount() -> String {
        account = storageManager.getAccount()
        return account.emailAccount
    }
    
    func getFirstName() -> String {
        account = storageManager.getAccount()
        return account.firstNameAccount
    }
    
    func getSecondName() -> String {
        account = storageManager.getAccount()
        return account.secondNameAccount
    }
    
    func getThirdName() -> String {
        account = storageManager.getAccount()
        return account.thirdNameAccount ?? ""
    }
    
    func getTimeCancelSosSignal() -> String {
        account = storageManager.getAccount()
        return "\(account.timeCancelSosSignal)"
    }
}
