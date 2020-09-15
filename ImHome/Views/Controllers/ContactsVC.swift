//
//  ContactsVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ContactsVC: UICollectionViewController, UISearchBarDelegate {
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    //MARK: Variables
    private let reuseIdentifier = "contactsCell"
    private var searchController: UISearchController!
    var row: Int?

    //Количество ячеек в строке
    private let countItems = CGFloat(2)
    //Отступ от краев экрана и по-середине
    private let paddingPlit = CGFloat(25)
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchNavController()
    }
    
    //MARK: Обработчики
    //MARK: Добавление нового контакта
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContactProfile" {
            guard let destination = segue.destination as? ProfileContactVC else { return }
            if row == 2 {
                destination.color = .systemOrange
            }
            
        }
    }

}

//MARK: Extensions Collection FlowLayout
extension ContactsVC: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: ContactsCell = collectionView.cellForItem(at: indexPath) as? ContactsCell else {return}
        cell.pulseAnimate(cell) {
            self.row = indexPath.row
            switch indexPath.row {
                case 0:
                    self.performSegue(withIdentifier: "showHelpMessageProfileContact", sender: self)
                    break
                case 1:
                    self.performSegue(withIdentifier: "showHelpMapProfileContact", sender: self)
                    break
                default:
                    self.performSegue(withIdentifier: "showContactProfile", sender: self)
                break
            }
        }
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
        if indexPath.row < 2 {
            cell.backgroundViewContacts.backgroundColor = .systemRed
            cell.nameContact.textColor = .white
            cell.emailContact.textColor = .white
            cell.micButton.tintColor = .white
            cell.mapButton.tintColor = .white
            cell.messageButton.tintColor = .white
        }
        if indexPath.row == 2 {
            cell.backgroundViewContacts.backgroundColor = .systemOrange
            cell.nameContact.textColor = .white
            cell.emailContact.textColor = .white
            cell.micButton.tintColor = .white
            cell.mapButton.tintColor = .white
            cell.messageButton.tintColor = .white
        }
        cell.widthConstraintPlit.constant = (collectionView.frame.width - paddingPlit * countItems) / countItems
        return cell
    }
}

//MARK: Extensions search results updating
extension ContactsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
}

