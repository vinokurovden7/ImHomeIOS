//
//  RegistrationVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 20.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit
import NVActivityIndicatorView

class RegistrationVC: UITableViewController {

    //MARK: IBOutlets
    @IBOutlet var emailTextField: UITextField! {
        didSet {
            textFieldSetup(textField: emailTextField)
        }
    }
    @IBOutlet var usernameTextField: UITextField!
    {
        didSet {
            textFieldSetup(textField: usernameTextField)
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            textFieldSetup(textField: passwordTextField)
        }
    }
    @IBOutlet weak var secondNameUser: UITextField! {
        didSet {
            textFieldSetup(textField: secondNameUser)
        }
    }
    @IBOutlet weak var firstNameUser: UITextField! {
        didSet {
            textFieldSetup(textField: firstNameUser)
        }
    }
    @IBOutlet weak var thirdNameUser: UITextField! {
        didSet {
            textFieldSetup(textField: thirdNameUser)
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
    
    //MARK: Variables
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: .ballPulse, color: .red, padding: 0)
        indicator.color = .gray
        //indicator.backgroundColor = UIColor(named: "backgroundViewColor")!
        indicator.layer.cornerRadius = indicator.frame.height / 2
        indicator.layer.borderColor = UIColor.white.cgColor
        indicator.layer.borderWidth = 0
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let myNotification = CustomNotification()
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        self.view.addSubview(indicator)
        indicator.centerYAnchor.constraint(equalToSystemSpacingBelow: self.view.centerYAnchor, multiplier: 0).isActive = true
        indicator.centerXAnchor.constraint(equalToSystemSpacingAfter: self.view.centerXAnchor, multiplier: 0).isActive = true
    }
    
    //MARK: Кастомные функции
    //MARK: Настройка текстовых полей
    fileprivate func textFieldSetup(textField: UITextField){
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.clipsToBounds = true
    }

    //MARK: Обработчики
    @IBAction func loginBtnAction(_ sender: CustomButton) {
        var description = ""
        
        if passwordTextField.text!.isEmpty {
            description = "Не заполнен пароль"
        }
        
        if usernameTextField.text!.isEmpty {
            description = "Не заполнено имя пользователя"
        }
        
        if firstNameUser.text!.isEmpty {
            description = "Не заполнено имя"
        }
        
        if secondNameUser.text!.isEmpty {
            description = "Не заполнена фамилия"
        }
        
        if emailTextField.text!.isEmpty {
            description = "Не заполнен Email"
        }

        if !description.isEmpty {
            myNotification.showNotification(title: "Упс", message: description, imageColor: nil, image: nil)
            return
        } else {
            indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.indicator.stopAnimating()
                self.dismiss(animated: true)
            }
        }
    }
    
    //MARK: Возвращение на экран авторизации
    @IBAction func goLoginScreenBtnAction(_ sender: CustomButton) {
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
