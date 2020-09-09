//
//  ProfileVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 24.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit
import LocalAuthentication

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
            imageProfile.isUserInteractionEnabled = true
        }
    }
    
    //MARK: Variables
    private let myNotification = CustomNotification()
    private let keychain = Keychain()
    var closure: ((Bool) -> ())?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageProfile.addGestureRecognizer(tapGestureRecognizer)

    }

    //MARK: Обработчики
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let cameraIcon = UIImage.init(named: "camera")
        let photoIcon = UIImage.init(named: "photoImage")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Сделать снимок", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Выбрать из галереи", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet,animated: true)
    }
    
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: Сохранение
    @IBAction func saveBtnAction(_ sender: CustomButton) {
        if emailTextField.text!.isEmpty {
            myNotification.showNotification(title: "Упс", message: "Укажите email", imageColor: nil, image: nil)
            return
        } else if secondNameTextField.text!.isEmpty {
            myNotification.showNotification(title: "Упс", message: "Укажите фамилию", imageColor: nil, image: nil)
            return
        } else if firstNameTextField.text!.isEmpty {
            myNotification.showNotification(title: "Упс", message: "Укажите имя", imageColor: nil, image: nil)
            return
        } else {
            myNotification.miniNotification(text: "Сохранено", color: .systemGreen)
            dismiss(animated: true)
        }
    }
    
    
    
    //MARK: Удаление аккаунта
    @IBAction func deleteAccountAction(_ sender: CustomButton) {
        keychain.removeKey(userAccount: "Home")
        dismiss(animated: true)
        closure?(true)
    }
    
    //MARK: Переход к работе с паролями
    @IBAction func showPasswordManagerAction(_ sender: CustomButton) {
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

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker,animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageProfile.image = info[.editedImage] as? UIImage
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case emailTextField:
                secondNameTextField.becomeFirstResponder()
            case secondNameTextField:
                firstNameTextField.becomeFirstResponder()
            case firstNameTextField:
                thirdNameTextField.becomeFirstResponder()
            case thirdNameTextField:
                self.view.endEditing(true)
            default:
                self.view.endEditing(true)
        }
        return true
    }
}
