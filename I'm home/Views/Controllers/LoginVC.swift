//
//  LoginVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var i = 0

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
    
    @IBAction func fogotPasswordBtnAction(_ sender: CustomButton) {
        
    }
    
    @IBAction func registrationBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showRegistrationScreen", sender: self)
    }
    @IBAction func autorizeBtnAction(_ sender: CustomButton) {
        if nameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
//            let title = "Kofi Shop"
//            let desc = "Over two weeks of quality coffee beans concentrated into a single entry kit"
//            let image = "ic_coffee_light"
//            let attributes = EKAttributes.bottomNote
//            showNotificationMessage(attributes: attributes,
//            title: title,
//            desc: desc,
//            textColor: .white,
//            imageName: image)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            
        } else {
            performSegue(withIdentifier: "autorizeAction", sender: self)
        }
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: Анимация полей ввода
    fileprivate func animateTextField(_ animationView: UIView){
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            animationView.frame.size.width += 10
        }) { (_) in
            UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                animationView.frame.size.width -= 10
            }, completion: nil)

        }
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

//// Bumps a notification structured entry
//private func showNotificationMessage(attributes: EKAttributes,
//                                     title: String,
//                                     desc: String,
//                                     textColor: EKColor,
//                                     imageName: String? = nil) {
//    let title = EKProperty.LabelContent(
//        text: title,
//        style: .init(
//            font: UIFont.systemFont(ofSize: 16),
//            color: textColor,
//            displayMode: .inferred
//        ),
//        accessibilityIdentifier: "title"
//    )
//    let description = EKProperty.LabelContent(
//        text: desc,
//        style: .init(
//            font: UIFont.systemFont(ofSize: 16),
//            color: textColor,
//            displayMode: .inferred
//        ),
//        accessibilityIdentifier: "description"
//    )
//    var image: EKProperty.ImageContent?
//    if let imageName = imageName {
//        image = EKProperty.ImageContent(
//            image: UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate),
//            displayMode: .inferred,
//            size: CGSize(width: 35, height: 35),
//            tint: textColor,
//            accessibilityIdentifier: "thumbnail"
//        )
//    }
//    let simpleMessage = EKSimpleMessage(
//        image: image,
//        title: title,
//        description: description
//    )
//    let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//    let contentView = EKNotificationMessageView(with: notificationMessage)
//    SwiftEntryKit.display(entry: contentView, using: attributes)
//}
