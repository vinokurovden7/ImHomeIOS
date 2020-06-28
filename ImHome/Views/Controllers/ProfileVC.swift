//
//  ProfileVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 24.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ProfileVC: UITableViewController {

    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            textFieldSetup(textField: emailTextField)
        }
    }

    @IBOutlet weak var secondNameTextField: UITextField! {
        didSet {
            textFieldSetup(textField: secondNameTextField)
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            textFieldSetup(textField: firstNameTextField)
        }
    }
    
    @IBOutlet weak var thirdNameTextField: UITextField! {
        didSet {
            textFieldSetup(textField: thirdNameTextField)
        }
    }
    
    @IBOutlet weak var changePasswordBtn: UIButton! {
        didSet {
            buttonSetup(button: changePasswordBtn)
        }
    }
    
    @IBOutlet weak var saveBtn: UIButton! {
        didSet {
            buttonSetup(button: saveBtn)
        }
    }
    
    @IBOutlet weak var deleteAccountBtn: UIButton! {
        didSet {
            buttonSetup(button: deleteAccountBtn)
        }
    }
    
    @IBOutlet weak var backgroundViewImageProfile: UIView! {
        didSet {
            backgroundViewImageProfile.layer.cornerRadius = backgroundViewImageProfile.frame.height / 2
            backgroundViewImageProfile.layer.shadowRadius = 4
            backgroundViewImageProfile.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewImageProfile.layer.shadowOpacity = 0.7
            backgroundViewImageProfile.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var imageProfile: UIImageView! {
        didSet {
            imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
            imageProfile.layer.borderColor = UIColor.white.cgColor
            imageProfile.layer.borderWidth = 2
            imageProfile.clipsToBounds = true
        }
    }
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07

    }

    //MARK: Обработчики
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: Сохранение
    @IBAction func saveBtnAction(_ sender: CustomButton) {
        SwiftEntryKit.display(entry: CustomNotification.sharedCustomNotification.getSaveNotifContentView(text: "Сохранено"), using: CustomNotification.sharedCustomNotification.saveNotifAttributes)
        dismiss(animated: true)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: Кастомные функции
    //MARK: Настройка текстовых полей
    fileprivate func textFieldSetup(textField: UITextField){
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.clipsToBounds = true
    }
    //MARK: Настройка кнопок
    fileprivate func buttonSetup(button: UIButton){
        button.layer.cornerRadius = button.frame.height / 2
    }
}
