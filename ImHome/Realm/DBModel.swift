//
//  DBModel.swift
//  ImHome
//
//  Created by Денис Винокуров on 19.08.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import RealmSwift

/// Акаунт пользователя
class Account: Object {
    @objc dynamic var idAccount = ""
    @objc dynamic var firstNameAccount = ""
    @objc dynamic var secondNameAccount = ""
    @objc dynamic var thirdNameAccount: String?
    @objc dynamic var emailAccount = ""
    @objc dynamic var photoAccount: Data?
    
    override class func primaryKey() -> String? {
        return "idAccount"
    }
}

/// Контакты пользователя
class Contact: Object {
    @objc dynamic var idContact = ""
    @objc dynamic var firstNameContact = ""
    @objc dynamic var secondNameContact = ""
    @objc dynamic var thirdNameContact: String?
    @objc dynamic var statusContact = 0
    @objc dynamic var helpMessageContact: String?
    @objc dynamic var useMicContact = false
    @objc dynamic var seePositionContact = false
    @objc dynamic var positionContact = ""
    @objc dynamic var photoContact: Data?
    @objc dynamic var signalPositionContact = ""
    @objc dynamic var emailContact = ""
    
    override class func primaryKey() -> String? {
        return "idContact"
    }
}
