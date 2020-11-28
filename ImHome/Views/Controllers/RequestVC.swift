//
//  RequestVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RequestVC: UIViewController {
    
    private lazy var arrayMessage = ["There are numerous success stories you will hear about businesses making it good on the internet . The troubling thing is, there are maybe a tenfold or even a hundredfold of stories inconsistent to theirs. Many have unsuccessfully launched a business venture that is internet based but only a handful shall succeed. There are numerous success stories you will hear about businesses making it good on the internet . The troubling thing is, there are maybe a tenfold or even a hundredfold of stories inconsistent to theirs. Many have unsuccessfully launched a business venture that is internet based but only a handful shall succeed.","There are numerous success stories you will hear about businesses making it good on the internet. Many have unsuccessfully. inconsistent to theirs", "Many have unsuccessfully "]
    private var viewModel: RequestVM?
    private let textLabel = UILabel()

    //MARK: IBOutlets
    @IBOutlet var requestTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RequestVM(typeRequest: segmentedControl.selectedSegmentIndex)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        guard let viewModel = viewModel else {return}
        viewModel.changeTypeRequest(typeRequest: sender.selectedSegmentIndex)
        requestTableView.reloadData()
    }
    
}

//MARK: Extensions TableView Delegate & DataSource
extension RequestVC: UITableViewDelegate, UITableViewDataSource, RequestCellActionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let viewModel = viewModel else {return 0}
//        return viewModel.numberOfRows()
        checkCountRecord()
        if arrayMessage.count > 0 {
            self.tabBarItem.badgeValue = "\(arrayMessage.count)"
        } else {
            self.tabBarItem.badgeValue = nil
        }
        return arrayMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell") as! RequestCell
        cell.delegate = self
        cell.messageTextLabel.text = arrayMessage[indexPath.row]
        return cell
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? RequestCell
//        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
//
//        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
//        tableViewCell.viewModel = cellViewModel
//
//        return tableViewCell
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
    
    func checkCountRecord() {
        if arrayMessage.count == 0 {
            textLabel.text = "Заявки в контакты отсутствуют"
            textLabel.font = UIFont.boldSystemFont(ofSize: 25.0)
            textLabel.textColor = .white
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.minimumScaleFactor = 0.5
            textLabel.numberOfLines = 1
            textLabel.frame = CGRect(x: view.frame.minX + 10, y: view.frame.minY - 20 + view.frame.size.height / 2, width: view.frame.size.width - 20, height: 34)
            textLabel.alpha = 0.0
            textLabel.textAlignment = .center
            
            view.addSubview(textLabel)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.textLabel.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                self.textLabel.alpha = 0.0
            })
            view.willRemoveSubview(textLabel)
        }
    }
}
