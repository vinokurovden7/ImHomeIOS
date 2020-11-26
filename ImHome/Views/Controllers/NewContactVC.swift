//
//  NewContactVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 26.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController, UISearchBarDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var myTableView: UITableView!
    //MARK: Variables
    private var searchController: UISearchController!
    private var counRecord = 10
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchNavController()
    }
    
    //MARK: Настройка searchController и  NavigationController
    /// Настройка searchController и  NavigationController
    func setSearchNavController(){
        navigationController?.setupNavigationController(navigationController: self.navigationController!)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor .white
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
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

//MARK: Extensions UITableView Delegate & DataSource
extension NewContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counRecord
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewContactCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        cell.nameContact.text = "Иванов Иван Иванович"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell: NewContactCell = myTableView.cellForRow(at: indexPath) as? NewContactCell else {return}
        cell.pulseAnimate(cell.mainViewContactCell) {
            self.performSegue(withIdentifier: "showAddedContact", sender: self)
        }
        
    }
    
}

//MARK: Extensions search results updating
extension NewContactVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
