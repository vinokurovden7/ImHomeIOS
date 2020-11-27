//
//  ContactCellVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
class ContactCellVM: ContactsCellDelegate {
    
    private let contact: Contact
    var nameContact: String {"\(contact.secondNameContact) \(contact.firstNameContact) \(contact.thirdNameContact ?? "")"}
    var emailContact: String {contact.emailContact}
    var imageContact: UIImage {UIImage(data: contact.photoContact!)!}
    var statusContact: Int {contact.statusContact}
    
    init(contact: Contact) {
        self.contact = contact
    }
}
