//
//  StorageManager.swift
//  ImHome
//
//  Created by Денис Винокуров on 19.08.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import RealmSwift

class StorageManager {
    
    //MARK: Сохранение данных
    /// Сохранение аккаунта
    /// - Parameter account: Объект типа Account
    func saveAccount(account: Account) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(account, update: .modified)
        }
    }
    
    /// Сохранение контакта
    /// - Parameter contact: Объект типа Contact
    func saveContact(contact: Contact) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(contact, update: .modified)
        }
    }
    
    //MARK: Удаление данных
    /// Удаление аккаунта
    /// - Parameter account: Объект типа Account
    func deleteAccount() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Account.self).first ?? Account())
        }
    }
    
    /// Удаление контакта
    /// - Parameter contact: Объект типа Contact
    func deleteContact(contact: Contact) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    /// Получить аккаунт
    /// - Returns: Объект типа Account
    func getAccount() -> Account {
        let realm = try! Realm()
        return realm.objects(Account.self).first ?? Account()
    }
}
