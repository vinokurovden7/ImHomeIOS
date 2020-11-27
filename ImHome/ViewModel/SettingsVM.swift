//
//  SettingsVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 26.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
class SettingsVM: SettingViewModelType {
    private let storageManager = StorageManager()
    private lazy var account = Account()
    
    /// Установка времени для отмены подачи сигнала о помощи
    /// - Parameter time: Время для отмены сигнала
    func setTimeCancelSosSignal(time: String) {
        account = storageManager.getAccount()
        let newAccount = Account()
        newAccount.idAccount = account.idAccount
        newAccount.firstNameAccount = account.firstNameAccount
        newAccount.secondNameAccount = account.secondNameAccount
        newAccount.thirdNameAccount = account.thirdNameAccount
        newAccount.emailAccount = account.emailAccount
        newAccount.photoAccount = account.photoAccount
        newAccount.timeCancelSosSignal = Int(time)!
        storageManager.saveAccount(account: newAccount)
    }
    
    /// Получение фото аккаунта
    /// - Returns: Объект UIImage
    func getPhotoAccount() -> UIImage {
        account = storageManager.getAccount()
        return UIImage(data: (account.photoAccount ?? UIImage(named: "camera")?.pngData())!)!
    }
    
    /// Получение склееной строки ФИО
    /// - Returns: Правильно склеенная строка ФИО
    func getFioAccount() -> String {
        account = storageManager.getAccount()
        return "\(account.secondNameAccount) \(account.firstNameAccount) \(account.thirdNameAccount ?? "")"
    }
    
    /// Получение Email адреса аккаунта
    /// - Returns: Email адрес
    func getEmailAccount() -> String {
        account = storageManager.getAccount()
        return account.emailAccount
    }
    
    /// Получение времени для отмены подачи сигнала о помощи
    /// - Returns: Время в виде строки
    func getTimeCancelSosSignal() -> String {
        account = storageManager.getAccount()
        return "\(account.timeCancelSosSignal)"
    }
    
}
