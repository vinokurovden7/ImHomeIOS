//
//  ProfileVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 24.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Введите Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var secondNameTextField: UITextField! {
        didSet {
            secondNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите фамилию",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var thirdNameTextField: UITextField! {
        didSet {
            thirdNameTextField.attributedPlaceholder = NSAttributedString(string: "Введите отчество",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var changePasswordBtn: UIButton! {
        didSet {
            changePasswordBtn.layer.cornerRadius = changePasswordBtn.frame.height / 2
        }
    }
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    @IBOutlet weak var deleteAccountBtn: UIButton! {
        didSet {
            deleteAccountBtn.layer.cornerRadius = deleteAccountBtn.frame.height / 2
        }
    }
    
    @IBOutlet weak var imageProfile: UIImageView! 
    
    @IBOutlet weak var backgroundViewProfileImage: UIView! {
        didSet {
            backgroundViewProfileImage.layer.cornerRadius = 20
            backgroundViewProfileImage.layer.shadowRadius = 4
            backgroundViewProfileImage.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewProfileImage.layer.shadowOpacity = 1
            backgroundViewProfileImage.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @IBOutlet weak var backgroundBtnView: UIView! {
        didSet {
            backgroundBtnView.layer.cornerRadius = backgroundBtnView.frame.height / 2
            backgroundBtnView.layer.shadowRadius = 4
            backgroundBtnView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundBtnView.layer.shadowOpacity = 1
            backgroundBtnView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Обработчики
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func saveBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func cancelBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
