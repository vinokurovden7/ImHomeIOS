//
//  RequestVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RequestVC: UIViewController {
    
    var arrayMessage = ["There are numerous success stories you will hear about businesses making it good on the internet . The troubling thing is, there are maybe a tenfold or even a hundredfold of stories inconsistent to theirs. Many have unsuccessfully launched a business venture that is internet based but only a handful shall succeed. There are numerous success stories you will hear about businesses making it good on the internet . The troubling thing is, there are maybe a tenfold or even a hundredfold of stories inconsistent to theirs. Many have unsuccessfully launched a business venture that is internet based but only a handful shall succeed.","There are numerous success stories you will hear about businesses making it good on the internet. Many have unsuccessfully. inconsistent to theirs", "Many have unsuccessfully "]

    //MARK: IBOutlets
    @IBOutlet var requestTableView: UITableView!
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}

//MARK: Extensions TableView Delegate & DataSource
extension RequestVC: UITableViewDelegate, UITableViewDataSource, RequestCellSubclassDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell") as! RequestCell
        cell.delegate = self
        
        cell.messageTextLabel.text = arrayMessage[indexPath.row]
        return cell
    }
    
    func acceptButtonTapped(cell: RequestCell) {
        guard let indexPath = self.requestTableView.indexPath(for: cell) else {return}
        arrayMessage.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.requestTableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func declineButtonTapped(cell: RequestCell) {
        guard let indexPath = self.requestTableView.indexPath(for: cell) else {return}
        arrayMessage.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.requestTableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
}
