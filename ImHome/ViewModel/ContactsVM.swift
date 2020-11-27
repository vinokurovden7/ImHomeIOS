//
//  ContactsVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 24.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import RealmSwift
class ContactsVM: ContactsViewModelType {
    
    //Количество ячеек в строке
    private let countItems:CGFloat
    //Отступ от краев экрана и по-середине
    private let paddingPlit:CGFloat
    private let collectionView: UICollectionView
    private let contacts: Results<Contact>!
    private let storageManager = StorageManager()
    
    init(collectionView: UICollectionView) {
        countItems = CGFloat(2)
        paddingPlit = CGFloat(25)
        self.collectionView = collectionView
        contacts = storageManager.getContacts(filter: nil)
    }
    
    init(countItems: CGFloat, paddingPlit: CGFloat, collectionView: UICollectionView) {
        self.countItems = countItems
        self.paddingPlit = paddingPlit
        self.collectionView = collectionView
        contacts = storageManager.getContacts(filter: nil)
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumbersItemsInSection() -> Int {
        let storageManager = StorageManager();
        return storageManager.getContacts(filter: nil)?.count ?? 0
    }
    
    func getMinimumLineSpacing() -> CGFloat {
        return CGFloat(bitPattern: 10)
    }
    
    func getEdgeInsets() -> UIEdgeInsets {
        let widthPlit = (collectionView.frame.width - paddingPlit * countItems) / countItems
        let superPadding = (collectionView.frame.width - widthPlit * countItems) / (countItems+1)
        let padding = (collectionView.frame.width - (superPadding + (countItems * widthPlit))) / countItems
        return UIEdgeInsets(top: 0, left: padding, bottom: 40, right: padding)
    }
    
    func getSizeItem() -> CGSize {
        return CGSize(width: (collectionView.frame.width - paddingPlit * countItems) / countItems, height: 155)
    }
    
    func getWidthPlits() -> CGFloat {
        return (collectionView.frame.width - paddingPlit * countItems) / countItems
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ContactsCellDelegate? {
        var contact = Contact()
        contact = contacts[indexPath.row]
        return ContactCellVM(contact: contact)
    }
    
}
