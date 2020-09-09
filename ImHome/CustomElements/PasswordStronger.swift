//
//  PasswordStronger.swift
//  ImHome
//
//  Created by Денис Винокуров on 09.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation

enum StrangePassword {
    case low
    case medium
    case high
}

class PasswordStronger {
    
    func checkPassword(password: String) -> StrangePassword {
        if password.range(of: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d].{8,}$", options: .regularExpression) != nil ||
        password.range(of: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&].{11,}$", options: .regularExpression) != nil ||
            password.range(of: "^(?=.*[A-Za-z]).{14,}$", options: .regularExpression) != nil || password.range(of: "^(?=.*[0-9]).{19,}$", options: .regularExpression) != nil ||
            password.range(of: "^(?=.*[!@#$&*]).{15,}$", options: .regularExpression) != nil{
            return .high
        } else if password.range(of: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d].{8,}$", options: .regularExpression) != nil || password.range(of: "^(?=.*[A-Za-z])(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#].{8,}$", options: .regularExpression) != nil || password.range(of: "^(?=.*\\d)[A-Za-z\\d](?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#].{8,}$", options: .regularExpression) != nil{
            return .medium
        } else {
            return .low
        }
    }
    
}
