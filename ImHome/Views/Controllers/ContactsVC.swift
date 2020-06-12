//
//  ContactsVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

private let reuseIdentifier = "contactsCell"
private var searchController: UISearchController!

let countItems = CGFloat(2)
let paddingPlit = CGFloat(16)

class ContactsVC: UICollectionViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchNavController()
    }
    
    @IBAction func addContactBtnAction(_ sender: UIBarButtonItem) {
        UIImpactFeedbackGenerator.init(style: .soft).impactOccurred()
    }
    //MARK: Setup
    /// Настройка searchController и  navigationController
    func setSearchNavController(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.barStyle = .black
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor .clear
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    //MARK: Визуальное оформление
    /// Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

//MARK: Extensions Collection FlowLayout
extension ContactsVC: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: ContactsCell = collectionView.cellForItem(at: indexPath) as? ContactsCell else {return}
        cell.pulseAnimate(cell) {
            self.performSegue(withIdentifier: "showContactProfile", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(bitPattern: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(bitPattern: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let widthPlit = (collectionView.frame.width - paddingPlit * countItems) / countItems
        let superPadding = (collectionView.frame.width - widthPlit * countItems) / (countItems+1)
        let padding = (collectionView.frame.width - (superPadding + (countItems * widthPlit))) / countItems
        return UIEdgeInsets(top: 0, left: padding, bottom: 40, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - paddingPlit * countItems) / countItems, height: 155)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 15
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ContactsCell
        
        cell.widthConstraintPlit.constant = (collectionView.frame.width - paddingPlit * countItems) / countItems
        
        return cell
    }
}

extension ContactsVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
}
