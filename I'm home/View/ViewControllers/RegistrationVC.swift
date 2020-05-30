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
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Введите Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Введите имя пользователя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var secondNameUser: UITextField! {
        didSet {
            secondNameUser.attributedPlaceholder = NSAttributedString(string: "Введите фамилию",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var firstNameUser: UITextField! {
        didSet {
            firstNameUser.attributedPlaceholder = NSAttributedString(string: "Введите имя",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var thirdNameUser: UITextField! {
        didSet {
            thirdNameUser.attributedPlaceholder = NSAttributedString(string: "Введите отчество",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var goLoginScreenBtn: UIButton!
    @IBOutlet weak var imageAccount: UIImageView!
    @IBOutlet weak var registrationBtn: UIButton! {
        didSet {
            registrationBtn.layer.cornerRadius = registrationBtn.frame.height / 2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
