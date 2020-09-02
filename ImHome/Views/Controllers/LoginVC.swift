//
//  LoginVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit
import RealmSwift

class LoginVC: UIViewController {
    
    //MARK: IBOutlets
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
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let contentView = CustomNotification.sharedCustomNotification.getFloatContentView(title: "Упс", desc: desc, textColor: EKColor(UIColor(named: "notifTextViewColor")!), imageColor: EKColor(UIColor.systemOrange), imageName: "exclamationmark.triangle.fill")
            let attributes = CustomNotification.sharedCustomNotification.floatAlertAttributes
            SwiftEntryKit.display(entry: contentView, using: attributes)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        } else {
            self.nameTextField.text = ""
            self.passwordTextField.text = ""
            performSegue(withIdentifier: "autorizeAction", sender: self)
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
