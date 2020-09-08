//
//  LoginVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit
import LocalAuthentication

class LoginVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var lockImageButton: CustomButton!
    @IBOutlet var fonImage: UIImageView!
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            setupTextFields(nameTextField)
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            setupTextFields(passwordTextField)
        }
    }
    
    private let myNotification = CustomNotification()
    private let keychain = Keychain()
    private let nameAccount = "Home"
    private var context = LAContext()
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let dict = keychain.getKey(userAccount: nameAccount) {
            lockImageButton.tintColor = .systemGreen
            nameTextField.text = dict["login"] as? String
        } else {
            lockImageButton.tintColor = .lightGray
        }
    }
    
    //MARK: Обработчики
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Забыл пароль
    @IBAction func fogotPasswordBtnAction(_ sender: CustomButton) {
    }
    
    //MARK: Регистрация
    @IBAction func registrationBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showRegistrationScreen", sender: self)
    }
    
    //MARK: Авторизация
    @IBAction func autorizeBtnAction(_ sender: CustomButton) {
        var desc = ""
        if passwordTextField.text!.isEmpty {
            desc = "Кажется, кто-то забыл заполнить поле пароля 😱"
        }
        
        if nameTextField.text!.isEmpty {
            desc = "Кажется, кто-то забыл заполнить поле имени пользователя 😱"
        }
        
        if nameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            myNotification.showNotification(title: "Упс", message: desc, imageColor: nil, image: nil)
        } else {
            if keychain.getKey(userAccount: nameAccount)?.isEmpty ?? true {
                keychain.addKey(data: ["login" : nameTextField.text!, "password" : passwordTextField.text!], userAccount: nameAccount)
                self.nameTextField.text = ""
                self.passwordTextField.text = ""
                performSegue(withIdentifier: "autorizeAction", sender: self)
            } else {
                guard let dict = keychain.getKey(userAccount: nameAccount) else {return}
                if nameTextField.text == dict["login"] as? String && passwordTextField.text == dict["password"] as? String {
                    self.nameTextField.text = ""
                    self.passwordTextField.text = ""
                    performSegue(withIdentifier: "autorizeAction", sender: self)
                } else {
                    myNotification.showNotification(title: "Ошибка", message: "Неверно указан логин или пароль", imageColor: .systemRed, image: "xmark.octagon.fill")
                }
            }
        }
    }
    
    //MARK: Нажатие на значок замка в поле ввода пароля
    @IBAction func lockImageButtonAction(_ sender: CustomButton) {
        if let _ = keychain.getKey(userAccount: nameAccount) {
            showBiomentricAutorization()
        }
    }
    
    /// Вызов авторизации через Touch или Face ID
    private func showBiomentricAutorization() {
        context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Автозаполнение пароля") { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        if let dict = self.keychain.getKey(userAccount: self.nameAccount) {
                            self.lockImageButton.tintColor = .systemGreen
                            self.nameTextField.text = dict["login"] as? String
                            self.passwordTextField.text = dict["password"] as? String
                            self.context.invalidate()
                            self.nameTextField.text = ""
                            self.passwordTextField.text = ""
                            self.performSegue(withIdentifier: "autorizeAction", sender: self)
                        }
                    }
                } else {
                    print("Ошибка авторизации через биометрию")
                }
            }
        }
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: Настройка полей ввода
    fileprivate func setupTextFields(_ textField: UITextField) {
        //Basic texfield Setup
        textField.borderStyle = .none
        textField.backgroundColor = .white
        //To apply corner radius
        textField.layer.cornerRadius = textField.frame.size.height / 2
        //To apply border
        textField.layer.borderWidth = 0.25
        //To apply Shadow
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowRadius = 5.0
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowColor = UIColor.black.cgColor //Any dark color
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.overrideUserInterfaceStyle = .light
    }
}
