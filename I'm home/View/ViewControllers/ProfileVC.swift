//
//  ProfileVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 24.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField! {
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
            emailTextField.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBOutlet weak var secondNameTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            secondNameTextField.borderStyle = .none
            secondNameTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            secondNameTextField.layer.cornerRadius = secondNameTextField.frame.size.height / 2

            //To apply border
            secondNameTextField.layer.borderWidth = 0.25
            secondNameTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            secondNameTextField.layer.shadowOpacity = 0.2
            secondNameTextField.layer.shadowRadius = 5.0
            secondNameTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            secondNameTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: secondNameTextField.frame.height))
            secondNameTextField.leftView = paddingView
            secondNameTextField.leftViewMode = UITextField.ViewMode.always
            secondNameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            secondNameTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            secondNameTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            secondNameTextField.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            firstNameTextField.borderStyle = .none
            firstNameTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            firstNameTextField.layer.cornerRadius = firstNameTextField.frame.size.height / 2

            //To apply border
            firstNameTextField.layer.borderWidth = 0.25
            firstNameTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            firstNameTextField.layer.shadowOpacity = 0.2
            firstNameTextField.layer.shadowRadius = 5.0
            firstNameTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            firstNameTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameTextField.frame.height))
            firstNameTextField.leftView = paddingView
            firstNameTextField.leftViewMode = UITextField.ViewMode.always
            firstNameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            firstNameTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            firstNameTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            firstNameTextField.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBOutlet weak var thirdNameTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            thirdNameTextField.borderStyle = .none
            thirdNameTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            thirdNameTextField.layer.cornerRadius = thirdNameTextField.frame.size.height / 2

            //To apply border
            thirdNameTextField.layer.borderWidth = 0.25
            thirdNameTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            thirdNameTextField.layer.shadowOpacity = 0.2
            thirdNameTextField.layer.shadowRadius = 5.0
            thirdNameTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            thirdNameTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: thirdNameTextField.frame.height))
            thirdNameTextField.leftView = paddingView
            thirdNameTextField.leftViewMode = UITextField.ViewMode.always
            thirdNameTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            thirdNameTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            thirdNameTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            thirdNameTextField.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBOutlet weak var changePasswordBtn: UIButton! {
        didSet {
            changePasswordBtn.layer.cornerRadius = changePasswordBtn.frame.height / 2
        }
    }
    
    @IBOutlet weak var saveBtn: UIButton! {
        didSet {
            saveBtn.layer.cornerRadius = saveBtn.frame.height / 2
        }
    }
    
    @IBOutlet weak var deleteAccountBtn: UIButton! {
        didSet {
            deleteAccountBtn.layer.cornerRadius = deleteAccountBtn.frame.height / 2
        }
    }
    
    @IBOutlet weak var imageProfile: UIImageView! {
        didSet {
            imageProfile.layer.cornerRadius = 20
            imageProfile.layer.borderWidth = 2
            imageProfile.layer.borderColor = UIColor.white.cgColor
            imageProfile.clipsToBounds = true
        }
    }
    
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
    @IBAction func saveBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
