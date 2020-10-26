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
import PhotosUI

class ProfileVC: UITableViewController {

    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var thirdNameTextField: UITextField!
    @IBOutlet weak var changePasswordBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var deleteAccountBtn: UIButton!
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
    var closure: ((Bool) -> ())?
    private var image = UIImage()
    private var viewModel: ProfileViewModelType?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.alpha = 0.07
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageProfile.addGestureRecognizer(tapGestureRecognizer)
        
        let account = StorageManager().getAccount()
        DispatchQueue.main.async {
            if !(account.photoAccount?.isEmpty ?? true) {
                self.imageProfile.image = UIImage(data: (account.photoAccount!))
                self.image = UIImage(data: (account.photoAccount!))!
            }
            self.firstNameTextField.text = account.firstNameAccount
            self.secondNameTextField.text = account.secondNameAccount
            self.thirdNameTextField.text = account.thirdNameAccount ?? ""
            self.emailTextField.text = account.emailAccount
        }
        viewModel = ProfileVM(viewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        guard let viewModel = viewModel else {return}
        viewModel.textFieldSetup(textField: emailTextField)
        viewModel.textFieldSetup(textField: firstNameTextField)
        viewModel.textFieldSetup(textField: secondNameTextField)
        viewModel.textFieldSetup(textField: thirdNameTextField)
        viewModel.buttonSetup(button: changePasswordBtn)
        viewModel.buttonSetup(button: saveBtn)
        viewModel.buttonSetup(button: deleteAccountBtn)
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
        guard let viewModel = viewModel else {return}
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
            let account = Account()
            account.emailAccount = emailTextField.text!
            account.firstNameAccount = firstNameTextField.text!
            account.secondNameAccount = secondNameTextField.text!
            account.thirdNameAccount = thirdNameTextField.text ?? ""
            account.photoAccount = image.jpeg(.low)
            viewModel.saveAccount(account: account)
            myNotification.miniNotification(text: "Сохранено", color: .systemGreen)
            dismiss(animated: true)
            closure?(false)
        }
    }
    
    //MARK: Удаление аккаунта
    @IBAction func deleteAccountAction(_ sender: CustomButton) {
        guard let viewModel = viewModel else {return}
        viewModel.deleteAccount()
        dismiss(animated: true)
        closure?(true)
    }
    
    //MARK: Переход к работе с паролями
    @IBAction func showPasswordManagerAction(_ sender: CustomButton) {
        guard let viewModel = viewModel else {return}
        viewModel.showPasswordManagerAction()
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    /// Выбор изображения
    /// - Parameter source: откуда брать изображение
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
    
    /// Обратотка выбранного изображения
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.editedImage] as? UIImage ?? UIImage()
        imageProfile.image = image
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.clipsToBounds = true
        dismiss(animated: true)
    }
    
    /// Обработка нажатия на кнопку Enter на клавиатуре
    /// - Parameter textField: поле, на котром происходит нажатие
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
    
    /// Функция смены пароля от аккаунта
    func changeAccountPass() {
        guard let viewModel = viewModel else {return}
        viewModel.changeAccountPass()
    }
    
    /// Функция смены локального пароля
    func changeLocalPass() {
        guard let viewModel = viewModel else {return}
        viewModel.changeLocalPass()
    }
}
