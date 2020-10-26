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
    @IBOutlet weak var showPasswordButton: UIButton! {
        didSet {
            showPasswordButton.isHidden = true
        }
    }
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
    
    //MARK: Variables
    private let myNotification = CustomNotification()
    private let nameAccount = "Home"
    private var context = LAContext()
    private var viewModel: LoginViewModelType?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        showHidePasswordButton()
        changeColorLockImage()
        passwordTextField.addTarget(self, action: #selector(editPasswordTF), for: .allEditingEvents)
        showPasswordButton.addTarget(self, action: #selector(touchDownBtn), for: .touchDown)
        showPasswordButton.addTarget(self, action: #selector(touchUpInsideBtn), for: [.touchUpInside,.touchDragExit])
        showPasswordButton.addTarget(self, action: #selector(allEvents), for: .allEvents)
        viewModel = LoginVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showHidePasswordButton()
        changeColorLockImage()
    }
    
    //MARK: Обработчики
    /// Изменение цвета  замка на поле ввода пароля
    private func changeColorLockImage() {
        guard let viewModel = viewModel  else {return}
        if !viewModel.getLogin().isEmpty {
            lockImageButton.tintColor = .systemGreen
            nameTextField.text = viewModel.getLogin()
        } else {
            lockImageButton.tintColor = .lightGray
        }
    }
    
    /// Обработчик любого взаимодействия с кнопкой показа пароля
    @objc func allEvents(){
        showPasswordButton.isHighlighted = false
    }
    
    /// Отображение кнопки показа пароля
    private func showHidePasswordButton() {
        print(passwordTextField.text!.isEmpty)
        showPasswordButton.isHidden = passwordTextField.text!.isEmpty
    }
    
    /// Нажатие кнопки показать пароль
    @objc func touchDownBtn() {
        UIImpactFeedbackGenerator.init(style: .soft).impactOccurred()
        showPasswordButton.setImage(UIImage.init(systemName: "eye"), for: .normal)
        passwordTextField.isSecureTextEntry = false
    }
    
    /// Отпускание кнопки показа пароля
    @objc func touchUpInsideBtn() {
        showPasswordButton.setImage(UIImage.init(named: "closedEye"), for: .normal)
        passwordTextField.isSecureTextEntry = true
    }
    
    /// Изменение значения в поле ввода пароля
    @objc func editPasswordTF() {
        showHidePasswordButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegistrationScreen" {
            guard let destination = segue.destination as? RegistrationVC else {return}
            destination.closure = {[weak self] dict in
                guard let viewModel = self!.viewModel else {return}
                viewModel.setLoginPassword(login: dict["login"] ?? "", password: dict["password"] ?? "")
                self!.nameTextField.text = dict["login"]
                self!.passwordTextField.text = dict["password"]
                self!.showHidePasswordButton()
            }
        }
    }
    
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
            guard let viewModel = viewModel else {return}
            if viewModel.getLogin().isEmpty && !viewModel.getAccount().emailAccount.isEmpty {
                viewModel.setLoginPassword(login: nameTextField.text!, password: passwordTextField.text!)
                self.nameTextField.text = ""
                self.passwordTextField.text = ""
                performSegue(withIdentifier: "autorizeAction", sender: self)
            } else {
                if self.nameTextField.text != viewModel.getLogin() {
                    myNotification.showNotification(title: "Ошибка", message: "Такой учетной записи не существует", imageColor: .systemRed, image: "xmark.octagon.fill")
                    return
                }
                if nameTextField.text == viewModel.getLogin() && passwordTextField.text == viewModel.getPassword() {
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
        guard let viewModel = viewModel else {return}
        if !viewModel.getLogin().isEmpty {
            showBiomentricAutorization()
        }
    }
    
    /// Вызов авторизации через Touch или Face ID
    private func showBiomentricAutorization() {
        context = LAContext()
        guard let viewModel = viewModel else {return}
        viewModel.showBiometrickAuth(context: context) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.context.invalidate()
                    self.nameTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "autorizeAction", sender: self)
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
    private func setupTextFields(_ textField: UITextField) {
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
        //To apply paddings
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 4)
        textField.layer.shadowColor = UIColor.black.cgColor
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        textField.overrideUserInterfaceStyle = .light
    }
}
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameTextField:
                passwordTextField.becomeFirstResponder()
            default:
                self.view.endEditing(true)
        }
        return true
    }
}
