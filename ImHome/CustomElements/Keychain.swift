//
//  Keychain.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Locksmith

/// Класс для раобты со связкой ключей
class Keychain {
    
    /// Сохранение данных в связку ключей
    /// - Parameters:
    ///   - data: Словарь данных
    ///   - userAccount: Название аккаунта
    func addKey(data: [String:String], userAccount : String){
        do {
            try Locksmith.saveData(data: data, forUserAccount : userAccount)
        } catch  {
            updateKey(data: data, userAccount: userAccount)
        }
    }
    
    /// Удаление из связки ключей
    /// - Parameter userAccount: Название аккаунта
    func removeKey(userAccount : String){
        do {
            try Locksmith.deleteDataForUserAccount(userAccount : userAccount)
        } catch {
            print("Ошибка при идалении значения из связки ключей")
        }
    }
    
    /// Обновление значенияв связке ключей
    /// - Parameters:
    ///   - data: Новый словарь данных
    ///   - userAccount: Название аккаунта
    func updateKey(data: [String : String], userAccount : String){
        do {
            try Locksmith.updateData(data: data, forUserAccount : userAccount)
        } catch {
            print("Ошибка при обновлении значения в связке ключей")
        }
    }
    
    /// Получить значение из связки ключей
    /// - Parameter userAccount: Название аккаунта
    /// - Returns: Данные в виде словаря
    func getKey(userAccount: String) -> [String:Any]? {
        let dict = Locksmith.loadDataForUserAccount(userAccount : userAccount)
        return dict
    }
    
}
