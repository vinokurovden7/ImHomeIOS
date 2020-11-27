//
//  NewContactCellVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
class NewContactCellVM: NewContactCellDelegate {
    
    private var newContact: NewContact
    
    var fullnameContact: String {newContact.fullNameNewContact}
    var emailContact: String {newContact.emailNewContact}
    var photoContact: UIImage {UIImage(data: newContact.photoNewContact!)!}
    
    init(newContact: NewContact) {
        self.newContact = newContact
    }
}
