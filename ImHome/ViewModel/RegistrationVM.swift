//
//  RegistrationVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation

class RegistrationVM: RegistrationViewModelType {
    
    func saveAccount(emailAccount: String, firstNameAccount: String, secondNameAccount: String, thirdNameAccount: String, photoAccount: Data) {
        
        let account = Account()
        account.emailAccount = emailAccount
        account.firstNameAccount = firstNameAccount
        account.secondNameAccount = secondNameAccount
        account.thirdNameAccount = thirdNameAccount
        account.photoAccount = photoAccount
        
        StorageManager().saveAccount(account: account)
    }
    
    
}
