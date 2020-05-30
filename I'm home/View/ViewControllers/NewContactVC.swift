//
//  NewContactVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 26.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController, UISearchBarDelegate {

    private var searchController: UISearchController!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.barStyle = .black
        
        setSearchNavController()

    }
    
    //MARK: Настройка searchController и  NavigationController
    func setSearchNavController(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor .white
        searchController.searchBar.barTintColor = UIColor .clear
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск"
       // searchController.searchResultsUpdater = self
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

extension NewContactVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewContactCell
        return cell
        
    }
    
    
}
