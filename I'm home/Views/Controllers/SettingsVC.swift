//
//  SettingsVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

    @IBOutlet weak var timeCancelSOSSignal: UITextField! {
        didSet {
            timeCancelSOSSignal.layer.cornerRadius = timeCancelSOSSignal.frame.height / 2
            timeCancelSOSSignal.clipsToBounds = true
        }
    }
    @IBOutlet weak var backgroundImageView: UIView! {
        didSet {
            backgroundImageView.layer.cornerRadius = backgroundImageView.frame.height / 2
            backgroundImageView.layer.shadowRadius = 4
            backgroundImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundImageView.layer.shadowOpacity = 1
            backgroundImageView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var editAccountButton: UIButton! {
        didSet {
            editAccountButton.layer.cornerRadius = editAccountButton.frame.height / 2
        }
    }
    @IBOutlet weak var profileImageVIew: UIImageView! {
        didSet {
            profileImageVIew.layer.cornerRadius = profileImageVIew.frame.width / 2
            profileImageVIew.layer.borderColor = UIColor.white.cgColor
            profileImageVIew.layer.borderWidth = 2
            profileImageVIew.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        
    }
    
    //MARK: Обработчики
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func editProfileBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showProfile", sender: self)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
