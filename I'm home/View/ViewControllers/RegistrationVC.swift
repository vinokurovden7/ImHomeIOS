//
//  RegistrationVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 20.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RegistrationVC: UITableViewController {

    @IBOutlet var emailTextField: UITextField! {
        didSet {
            emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
            emailTextField.clipsToBounds = true
        }
    }
    @IBOutlet var usernameTextField: UITextField!
    {
        didSet {
            usernameTextField.layer.cornerRadius = usernameTextField.frame.height / 2
            usernameTextField.clipsToBounds = true
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
            passwordTextField.clipsToBounds = true
        }
    }
    @IBOutlet weak var secondNameUser: UITextField! {
        didSet {
            secondNameUser.layer.cornerRadius = secondNameUser.frame.height / 2
            secondNameUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var firstNameUser: UITextField! {
        didSet {
            firstNameUser.layer.cornerRadius = firstNameUser.frame.height / 2
            firstNameUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var thirdNameUser: UITextField! {
        didSet {
            thirdNameUser.layer.cornerRadius = thirdNameUser.frame.height / 2
            thirdNameUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var goLoginScreenBtn: UIButton!
    @IBOutlet weak var backgroundViewImageAccount: UIView! {
        didSet {
            backgroundViewImageAccount.layer.cornerRadius = backgroundViewImageAccount.frame.height / 2
            backgroundViewImageAccount.layer.shadowRadius = 4
            backgroundViewImageAccount.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewImageAccount.layer.shadowOpacity = 0.7
            backgroundViewImageAccount.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var imageAccount: UIImageView! {
        didSet {
            imageAccount.layer.cornerRadius = imageAccount.frame.height / 2
            imageAccount.layer.borderColor = UIColor.white.cgColor
            imageAccount.layer.borderWidth = 2
            imageAccount.clipsToBounds = true
        }
    }
    @IBOutlet weak var registrationBtn: UIButton! {
        didSet {
            registrationBtn.layer.cornerRadius = registrationBtn.frame.height / 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        
    }

    //MARK: Обработчики
    @IBAction func loginBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func goLoginScreenBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
