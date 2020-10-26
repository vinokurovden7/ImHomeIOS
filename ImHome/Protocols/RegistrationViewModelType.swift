//
//  RegistrationViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
import PhotosUI

protocol RegistrationViewModelType {
    func saveAccount(emailAccount: String, firstNameAccount: String, secondNameAccount: String, thirdNameAccount: String, photoAccount: Data)
}
