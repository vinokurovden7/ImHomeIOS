//
//  ProfileContactVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 25.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ProfileContactVC: UIViewController {

    @IBOutlet weak var emailProfileTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            emailProfileTextField.borderStyle = .none
            emailProfileTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            emailProfileTextField.layer.cornerRadius = emailProfileTextField.frame.size.height / 2

            //To apply border
            emailProfileTextField.layer.borderWidth = 0.25
            emailProfileTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            emailProfileTextField.layer.shadowOpacity = 0.2
            emailProfileTextField.layer.shadowRadius = 5.0
            emailProfileTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            emailProfileTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: emailProfileTextField.frame.height))
            emailProfileTextField.leftView = paddingView
            emailProfileTextField.leftViewMode = UITextField.ViewMode.always
            emailProfileTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            emailProfileTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            emailProfileTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            emailProfileTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var secondNameProfileTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            secondNameProfileTextField.borderStyle = .none
            secondNameProfileTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            secondNameProfileTextField.layer.cornerRadius = secondNameProfileTextField.frame.size.height / 2

            //To apply border
            secondNameProfileTextField.layer.borderWidth = 0.25
            secondNameProfileTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            secondNameProfileTextField.layer.shadowOpacity = 0.2
            secondNameProfileTextField.layer.shadowRadius = 5.0
            secondNameProfileTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            secondNameProfileTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: secondNameProfileTextField.frame.height))
            secondNameProfileTextField.leftView = paddingView
            secondNameProfileTextField.leftViewMode = UITextField.ViewMode.always
            secondNameProfileTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            secondNameProfileTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            secondNameProfileTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            secondNameProfileTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var firstNameProfileTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            firstNameProfileTextField.borderStyle = .none
            firstNameProfileTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            firstNameProfileTextField.layer.cornerRadius = firstNameProfileTextField.frame.size.height / 2

            //To apply border
            firstNameProfileTextField.layer.borderWidth = 0.25
            firstNameProfileTextField.layer.borderColor = UIColor.white.cgColor

            //To apply Shadow
            firstNameProfileTextField.layer.shadowOpacity = 0.2
            firstNameProfileTextField.layer.shadowRadius = 5.0
            firstNameProfileTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
            firstNameProfileTextField.layer.shadowColor = UIColor.gray.cgColor

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: firstNameProfileTextField.frame.height))
            firstNameProfileTextField.leftView = paddingView
            firstNameProfileTextField.leftViewMode = UITextField.ViewMode.always
            firstNameProfileTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            firstNameProfileTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            firstNameProfileTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            firstNameProfileTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var thirdNameProfileTextField: UITextField! {
        didSet {
            //Basic texfield Setup
            thirdNameProfileTextField.borderStyle = .none
            thirdNameProfileTextField.backgroundColor = .white // Use anycolor that give you a 2d look.

            //To apply corner radius
            thirdNameProfileTextField.layer.cornerRadius = thirdNameProfileTextField.frame.size.height / 2

            //To apply border
            thirdNameProfileTextField.layer.borderWidth = 0.25

            //To apply Shadow
            thirdNameProfileTextField.layer.shadowOpacity = 0.2
            thirdNameProfileTextField.layer.shadowRadius = 5.0

            //To apply padding
            let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: thirdNameProfileTextField.frame.height))
            thirdNameProfileTextField.leftView = paddingView
            thirdNameProfileTextField.leftViewMode = UITextField.ViewMode.always
            thirdNameProfileTextField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
            thirdNameProfileTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
            thirdNameProfileTextField.layer.shadowColor = UIColor.black.cgColor //Any dark color
            thirdNameProfileTextField.overrideUserInterfaceStyle = .light
        }
    }
    @IBOutlet weak var deletePersonBtn: UIButton! {
        didSet {
            deletePersonBtn.layer.cornerRadius = deletePersonBtn.frame.height / 2
        }
    }
    @IBOutlet weak var imageContact: UIImageView! {
        didSet {
            imageContact.layer.cornerRadius = 20
            imageContact.layer.borderWidth = 2
            imageContact.layer.borderColor = UIColor.white.cgColor
            imageContact.clipsToBounds = true
        }
    }
    @IBOutlet weak var backgroundViewContactImage: UIView! {
        didSet {
            backgroundViewContactImage.layer.cornerRadius = 20
            backgroundViewContactImage.layer.shadowRadius = 4
            backgroundViewContactImage.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewContactImage.layer.shadowOpacity = 1
            backgroundViewContactImage.layer.shadowColor = UIColor.black.cgColor
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
