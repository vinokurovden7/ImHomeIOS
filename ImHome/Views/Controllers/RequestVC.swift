//
//  RequestVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RequestVC: UIViewController {

    @IBOutlet var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}

extension RequestVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell") as! RequestCell
        
        return cell
    }
}
