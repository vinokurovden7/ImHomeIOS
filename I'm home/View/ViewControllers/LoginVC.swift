//
//  LoginVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var fonImage: UIImageView!
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            nameTextField.borderStyle = .none
            nameTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            nameTextField.layer.cornerRadius = nameTextField.frame.size.height / 2

            //To apply border
            nameTextField.layer.borderWidth = 0.25
            nameTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            nameTextField.layer.shadowOpacity = 0.2
            nameTextField.layer.shadowRadius = 5.0
            nameTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            nameTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: nameTextField.frame.height))
            nameTextField.leftView = paddingView
            nameTextField.leftViewMode = UITextField.ViewMode.always
            nameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            nameTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            nameTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
            nameTextField.leftViewMode = UITextField.ViewMode.always
            nameTextField.leftView = spacerView
            nameTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            passwordTextField.borderStyle = .none
            passwordTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height / 2

            //To apply border
            passwordTextField.layer.borderWidth = 0.25
            passwordTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            passwordTextField.layer.shadowOpacity = 0.2
            passwordTextField.layer.shadowRadius = 5.0
            passwordTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            passwordTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: passwordTextField.frame.height))
            passwordTextField.leftView = paddingView
            passwordTextField.leftViewMode = UITextField.ViewMode.always
            passwordTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            passwordTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
            passwordTextField.leftViewMode = UITextField.ViewMode.always
            passwordTextField.leftView = spacerView
            passwordTextField.overrideUserInterfaceStyle = .light
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
    
    @IBAction func registrationBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showRegistrationScreen", sender: self)
    }
    @IBAction func autorizeBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "autorizeAction", sender: self)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

