//
//  StorageManager.swift
//  ImHome
//
//  Created by Денис Винокуров on 19.08.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import RealmSwift

/// Класс для работы с базой данных Realm
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
    
    //MARK: Выборка данных
    /// Получить аккаунт
    /// - Returns: Объект типа Account
    func getAccount() -> Account {
        let realm = try! Realm()
        return realm.objects(Account.self).first ?? Account()
    }
    
    /// Получить контакты
    /// - Parameter filter: параметр поиска
    /// - Returns: Объект запроса Contact
    func getContacts(filter: String?) -> Results<Contact>! {
        let realm = try! Realm()
        if let filter = filter {
            return realm.objects(Contact.self).filter("firstNameContact CONTAINS[c] %@ OR secondNameContact CONTAINS[c] %@ OR thirdNameContact CONTAINS[c] %@", filter ,filter).sorted(byKeyPath: "firstNameContact").sorted(byKeyPath: "secondNameContact").sorted(byKeyPath: "thirdNameContact")
        } else {
            return realm.objects(Contact.self).sorted(byKeyPath: "firstNameContact").sorted(byKeyPath: "secondNameContact").sorted(byKeyPath: "thirdNameContact")
        }
    }
    
    /// Получить запросы на добавления в контакты
    /// - Returns: Объект запроса Request
    func getRequests() -> Results<Request>! {
        let realm = try! Realm()
        return realm.objects(Request.self)
    }
    
    func getNewConacts() -> Results<NewContact>! {
        let realm = try! Realm()
        return realm.objects(NewContact.self).sorted(byKeyPath: "fullNameNewContact")
    }
    
}
