//
//  LoginVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var fonImage: UIImageView!
    @IBOutlet var nameTextField: UITextField! {
        didSet {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: nameTextField.frame.height+2, width: nameTextField.frame.width, height: 1)
            bottomLine.backgroundColor = UIColor.lightGray.cgColor
            nameTextField.borderStyle = .none
            nameTextField.layer.addSublayer(bottomLine)
            let spacerView = UIView(frame:CGRect(x:0, y:0, width:35, height:10))
            nameTextField.leftViewMode = UITextField.ViewMode.always
            nameTextField.leftView = spacerView
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: passwordTextField.frame.height+2, width: passwordTextField.frame.width, height: 1)
            bottomLine.backgroundColor = UIColor.lightGray.cgColor
            passwordTextField.borderStyle = .none
            passwordTextField.layer.addSublayer(bottomLine)
            let spacerView = UIView(frame:CGRect(x:0, y:0, width:35, height:10))
            passwordTextField.leftViewMode = UITextField.ViewMode.always
            passwordTextField.leftView = spacerView
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

