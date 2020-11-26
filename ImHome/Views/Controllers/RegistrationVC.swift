//
//  RegistrationVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 20.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit
import NVActivityIndicatorView
import PhotosUI

class RegistrationVC: UITableViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var shieldImagePassword: UIImageView! {didSet {shieldImagePassword.alpha = 0}}
    @IBOutlet weak var messageStrongerPassword: UILabel! {didSet {messageStrongerPassword.alpha = 0}}
    @IBOutlet var emailTextField: UITextField! {didSet {textFieldSetup(textField: emailTextField)}}
    @IBOutlet var usernameTextField: UITextField!{didSet {textFieldSetup(textField: usernameTextField)}}
    @IBOutlet var passwordTextField: UITextField! {
        didSet {
            textFieldSetup(textField: passwordTextField)
            passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            textFieldSetup(textField: confirmPasswordTextField)
            confirmPasswordTextField.layer.cornerRadius = confirmPasswordTextField.frame.height / 2
        }
    }
    @IBOutlet weak var secondNameUser: UITextField! {didSet {textFieldSetup(textField: secondNameUser)}}
    @IBOutlet weak var firstNameUser: UITextField! {didSet {textFieldSetup(textField: firstNameUser)}}
    @IBOutlet weak var thirdNameUser: UITextField! {didSet {textFieldSetup(textField: thirdNameUser)}}
    @IBOutlet weak var confirmPasswordMessage: UILabel! {didSet {confirmPasswordMessage.alpha = 0}}
    @IBOutlet weak var passwordMessage: UILabel! {didSet {passwordMessage.alpha = 0}}
    @IBOutlet weak var goLoginScreenBtn: UIButton!
    @IBOutlet weak var backgroundViewImageAccount: UIView! {
        didSet {
            backgroundViewImageAccount.layer.cornerRadius = backgroundViewImageAccount.frame.height / 2
            backgroundViewImageAccount.layer.shadowRadius = 4
            backgroundViewImageAccount.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewImageAccount.layer.shadowOpacity = 0.7
            backgroundViewImageAccount.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var imageAccount: UIImageView! {
        didSet {
            imageAccount.layer.cornerRadius = imageAccount.frame.height / 2
            imageAccount.layer.borderColor = UIColor.white.cgColor
            imageAccount.layer.borderWidth = 2
            imageAccount.clipsToBounds = true
            imageAccount.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var registrationBtn: UIButton! {didSet {registrationBtn.layer.cornerRadius = registrationBtn.frame.height / 2}}
    
    //MARK: Variables
    private var indicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 51, height: 51), type: .ballClipRotateMultiple, color: .white, padding: 0)
        indicator.layer.borderWidth = 0
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.alpha = 0
        return indicator
    }()
    private let durationAnimation = 0.3
    private let myNotification = CustomNotification()
    private let strongerPass = PasswordStronger()
    var closure: (([String:String]) -> ())?
    private var viewModel: RegistrationViewModelType?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        
        confirmPasswordTextField.addTarget(self, action: #selector(changeValue), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(changedPasswordTF), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(endChangePassword), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(endChangeConfirmPassword), for: .editingDidEnd)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageAccount.addGestureRecognizer(tapGestureRecognizer)
        
        viewModel = RegistrationVM()
    }
    
    //MARK: Кастомные функции
    
    /// Нажатие на изображение
    /// - Parameter tapGestureRecognizer: Gesture Recognizer
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
    
    //MARK: Настройка текстовых полей
    fileprivate func textFieldSetup(textField: UITextField){
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.clipsToBounds = true
    }

    //MARK: Обработчики
    
    /// Окончание изменений в поле пароля
    @objc func endChangePassword() {
        if self.passwordTextField.text!.isEmpty || self.passwordTextField.text!.count >= 8 {
            self.passwordTextField.animateBorderWidth(toValue: 0, duration: durationAnimation)
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                self.passwordMessage.alpha = 0
            })
        }
        if passwordTextField.text!.isEmpty {
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                self.shieldImagePassword.alpha = 0
                self.messageStrongerPassword.alpha = 0
            })
        }
    }
    
    /// Окончание изменений в поле подтверждения пароля
    @objc func endChangeConfirmPassword() {
        if passwordTextField.text == self.confirmPasswordTextField.text || passwordTextField.text!.isEmpty {
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveEaseIn, animations: {
                self.confirmPasswordMessage.alpha = 0
            })
            confirmPasswordTextField.animateBorderWidth(toValue: 0, duration: durationAnimation)
        }
    }
    
    /// Изменение значения в поле пароля
    @objc func changedPasswordTF() {
        passwordTextField.text! = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
            self.messageStrongerPassword.alpha = 1
        })
        
        switch strongerPass.checkPassword(password: passwordTextField.text!) {
            case .high:
                UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                    self.shieldImagePassword.alpha = 1
                    self.shieldImagePassword.tintColor = .systemGreen
                    self.shieldImagePassword.image = UIImage.init(systemName: "checkmark.shield.fill")
                })
                messageStrongerPassword.text = "Надежный пароль"
                passwordTextField.animateBorderColor(toValue: UIColor.systemGreen.cgColor, duration: durationAnimation)
            case .medium:
                UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                    self.shieldImagePassword.alpha = 1
                    self.shieldImagePassword.tintColor = .systemYellow
                    self.shieldImagePassword.image = UIImage.init(systemName: "exclamationmark.shield.fill")
                })
                messageStrongerPassword.text = "Средний пароль"
                passwordTextField.animateBorderColor(toValue: UIColor.systemYellow.cgColor, duration: durationAnimation)
            case .low:
                UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                    self.shieldImagePassword.alpha = 1
                    self.shieldImagePassword.tintColor = .systemRed
                    self.shieldImagePassword.image = UIImage.init(systemName: "xmark.shield.fill")
                })
                messageStrongerPassword.text = "Ненадежный пароль"
                passwordTextField.animateBorderColor(toValue: UIColor.systemRed.cgColor, duration: durationAnimation)
        }
        
        if !passwordTextField.text!.isEmpty && passwordTextField.text!.count < 8 {
            passwordTextField.animateBorderWidth(toValue: 2.0, duration: durationAnimation)
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                self.passwordMessage.alpha = 1
            })
        } else if !passwordTextField.text!.isEmpty && passwordTextField.text!.count >= 8 {
            passwordTextField.animateBorderWidth(toValue: 2.0, duration: durationAnimation)
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                self.passwordMessage.alpha = 0
            })
        }
        confirmPasswordTextField.text = ""
        UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
            self.confirmPasswordMessage.alpha = 0
        })
        confirmPasswordTextField.animateBorderWidth(toValue: 0, duration: durationAnimation)
    }
    
    /// Изменение значения в поле подтверждения пароля
    @objc func changeValue() {
        confirmPasswordTextField.text! = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespaces)
        
        if passwordTextField.text == confirmPasswordTextField.text && !passwordTextField.text!.isEmpty {
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveLinear, animations: {
                self.confirmPasswordMessage.alpha = 0
            })
            confirmPasswordTextField.animateBorderColor(toValue: UIColor.systemGreen.cgColor, duration: durationAnimation)
        } else {
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveEaseIn, animations: {
                self.confirmPasswordMessage.alpha = 1
            })
            confirmPasswordTextField.animateBorderWidth(toValue: 2.0, duration: durationAnimation)
            confirmPasswordTextField.animateBorderColor(toValue: UIColor.systemRed.cgColor, duration: durationAnimation)
        }
    }
    
    //MARK: Регистрация
    @IBAction func registrationBtnAction(_ sender: CustomButton) {
        var description = ""
        if passwordTextField.text! != confirmPasswordTextField.text {description = "Введенные пароли не совпадают"}
        if passwordTextField.text!.count < 8 {description = "Пароль должен быть не менее 8 символов"}
        if passwordTextField.text!.isEmpty {description = "Не заполнен пароль"}
        if usernameTextField.text!.isEmpty {description = "Не заполнено имя пользователя"}
        if firstNameUser.text!.isEmpty {description = "Не заполнено имя"}
        if secondNameUser.text!.isEmpty {description = "Не заполнена фамилия"}
        if emailTextField.text!.isEmpty {description = "Не заполнен Email"}
        

        if !description.isEmpty {
            myNotification.showNotification(title: "Упс", message: description, imageColor: nil, image: nil)
            return
        } else {
            goLoginScreenBtn.isEnabled = false
            self.view.addSubview(indicator)
            indicator.centerYAnchor.constraint(equalToSystemSpacingBelow: registrationBtn.centerYAnchor, multiplier: 0).isActive = true
            indicator.centerXAnchor.constraint(equalToSystemSpacingAfter: registrationBtn.centerXAnchor, multiplier: 0).isActive = true
            
            UIView.animate(withDuration: durationAnimation, delay: 0, options: .curveEaseIn, animations: {
                self.registrationBtn.alpha = 0
            }) { _ in
                UIView.animate(withDuration: self.durationAnimation, delay: 0, options: .curveEaseIn, animations: {
                    self.indicator.alpha = 1
                })
            }
            tableView.isScrollEnabled = false
            indicator.startAnimating()
            
            viewModel?.saveAccount(emailAccount: emailTextField.text!, firstNameAccount: firstNameUser.text!, secondNameAccount: secondNameUser.text!, thirdNameAccount: thirdNameUser.text!, photoAccount: (imageAccount.image?.jpegData(.low))!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.indicator.stopAnimating()
                self.tableView.isScrollEnabled = true
                self.closure?(["login":self.usernameTextField.text!, "password":self.passwordTextField.text!])
                self.dismiss(animated: true)
            }
        }
    }
    
    //MARK: Возвращение на экран авторизации
    @IBAction func goLoginScreenBtnAction(_ sender: CustomButton) {
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

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            if source == .camera {
                imagePicker.cameraDevice = .front
                imagePicker.cameraFlashMode = .auto
                imagePicker.showsCameraControls = true
            }
            present(imagePicker,animated: true)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageAccount.image = info[.editedImage] as? UIImage
        imageAccount.contentMode = .scaleAspectFill
        imageAccount.clipsToBounds = true
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case emailTextField:
                secondNameUser.becomeFirstResponder()
            case secondNameUser:
                firstNameUser.becomeFirstResponder()
            case firstNameUser:
                thirdNameUser.becomeFirstResponder()
            case thirdNameUser:
                usernameTextField.becomeFirstResponder()
            case usernameTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                confirmPasswordTextField.becomeFirstResponder()
            case confirmPasswordTextField:
                self.view.endEditing(true)
            default:
                self.view.endEditing(true)
        }
        return true
    }
}
