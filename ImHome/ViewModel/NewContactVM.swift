//
//  NewContactVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
import RealmSwift
class NewContactVM: NewContactViewModelType {
    
    private let storageManager = StorageManager()
    private var newContacts:Results<NewContact>!
    private var filteringNewContacts:Results<NewContact>!
    private lazy var isFiltering = false
    
    func numberOfRowsInSection() -> Int {
        newContacts = storageManager.getNewConacts()
        if newContacts.count > 0 {
            return isFiltering ? filteringNewContacts.count : newContacts.count
        } else {
            return 0
        }
//        if isFiltering {
//            return filteringNewContacts.count
//        } else {
//            return newContacts.count
//        }
    }
    
    func filteringContact(filteredString: String) {
        isFiltering = filteredString.count > 0
        filteringNewContacts = newContacts.filter("fullNameNewContact CONTAINS[c] %@ OR emailNewContact CONTAINS[c] %@", filteredString, filteredString)
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewContactCellDelegate? {
        var newContact = NewContact()
        newContact = isFiltering ? filteringNewContacts[indexPath.row] : newContacts[indexPath.row]
        return NewContactCellVM(newContact: newContact)
    }
}
