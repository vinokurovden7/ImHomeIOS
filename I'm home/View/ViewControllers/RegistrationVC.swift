//
//  RegistrationVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 20.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var emailTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            emailTextField.borderStyle = .none
            emailTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            emailTextField.layer.cornerRadius = emailTextField.frame.size.height / 2

            //To apply border
            emailTextField.layer.borderWidth = 0.25
            emailTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            emailTextField.layer.shadowOpacity = 0.2
            emailTextField.layer.shadowRadius = 5.0
            emailTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            emailTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: emailTextField.frame.height))
            emailTextField.leftView = paddingView
            emailTextField.leftViewMode = UITextField.ViewMode.always
            emailTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            emailTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            emailTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            emailTextField.leftViewMode = UITextField.ViewMode.always
//            emailTextField.leftView = spacerView
            emailTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            usernameTextField.borderStyle = .none
            usernameTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            usernameTextField.layer.cornerRadius = usernameTextField.frame.size.height / 2

            //To apply border
            usernameTextField.layer.borderWidth = 0.25
            usernameTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            usernameTextField.layer.shadowOpacity = 0.2
            usernameTextField.layer.shadowRadius = 5.0
            usernameTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            usernameTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: usernameTextField.frame.height))
            usernameTextField.leftView = paddingView
            usernameTextField.leftViewMode = UITextField.ViewMode.always
            usernameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            usernameTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            usernameTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            usernameTextField.leftViewMode = UITextField.ViewMode.always
//            usernameTextField.leftView = spacerView
            usernameTextField.overrideUserInterfaceStyle = .light
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
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            passwordTextField.leftViewMode = UITextField.ViewMode.always
//            passwordTextField.leftView = spacerView
            passwordTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var secondNameUser: UITextField! {
        didSet {
            //Basic texfield Setup
            secondNameUser.borderStyle = .none
            secondNameUser.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            secondNameUser.layer.cornerRadius = secondNameUser.frame.size.height / 2

            //To apply border
            secondNameUser.layer.borderWidth = 0.25
            secondNameUser.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            secondNameUser.layer.shadowOpacity = 0.2
            secondNameUser.layer.shadowRadius = 5.0
            secondNameUser.layer.shadowOffset = CGSize.zero // Use any CGSize
            secondNameUser.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: secondNameUser.frame.height))
            secondNameUser.leftView = paddingView
            secondNameUser.leftViewMode = UITextField.ViewMode.always
            secondNameUser.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            secondNameUser.layer.shadowOffset = CGSize(width: 0, height: 4)
            secondNameUser.layer.shadowColor = UIColor.black.cgColor //Any dark color
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            secondNameUser.leftViewMode = UITextField.ViewMode.always
//            secondNameUser.leftView = spacerView
            secondNameUser.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var firstNameUser: UITextField! {
        didSet {
            //Basic texfield Setup
            firstNameUser.borderStyle = .none
            firstNameUser.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            firstNameUser.layer.cornerRadius = firstNameUser.frame.size.height / 2

            //To apply border
            firstNameUser.layer.borderWidth = 0.25
            firstNameUser.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            firstNameUser.layer.shadowOpacity = 0.2
            firstNameUser.layer.shadowRadius = 5.0
            firstNameUser.layer.shadowOffset = CGSize.zero // Use any CGSize
            firstNameUser.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameUser.frame.height))
            firstNameUser.leftView = paddingView
            firstNameUser.leftViewMode = UITextField.ViewMode.always
            firstNameUser.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            firstNameUser.layer.shadowOffset = CGSize(width: 0, height: 4)
            firstNameUser.layer.shadowColor = UIColor.black.cgColor //Any dark color
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            firstNameUser.leftViewMode = UITextField.ViewMode.always
//            firstNameUser.leftView = spacerView
            firstNameUser.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var thirdNameUser: UITextField! {
        didSet {
            //Basic texfield Setup
            thirdNameUser.borderStyle = .none
            thirdNameUser.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            thirdNameUser.layer.cornerRadius = thirdNameUser.frame.size.height / 2

            //To apply border
            thirdNameUser.layer.borderWidth = 0.25
            thirdNameUser.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            thirdNameUser.layer.shadowOpacity = 0.2
            thirdNameUser.layer.shadowRadius = 5.0
            thirdNameUser.layer.shadowOffset = CGSize.zero // Use any CGSize
            thirdNameUser.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: thirdNameUser.frame.height))
            thirdNameUser.leftView = paddingView
            thirdNameUser.leftViewMode = UITextField.ViewMode.always
            thirdNameUser.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            thirdNameUser.layer.shadowOffset = CGSize(width: 0, height: 4)
            thirdNameUser.layer.shadowColor = UIColor.black.cgColor //Any dark color
//            let spacerView = UIView(frame:CGRect(x:0, y:0, width:40, height:10))
//            thirdNameUser.leftViewMode = UITextField.ViewMode.always
//            thirdNameUser.leftView = spacerView
            thirdNameUser.overrideUserInterfaceStyle = .light
        }
    }
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
