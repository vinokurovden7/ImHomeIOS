//
//  LockerViewController.swift
//  ImHome
//
//  Created by Денис Винокуров on 03.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import LocalAuthentication

class LockerViewController: UIViewController {
    
    //MARK: Переменные
    private var password = ""
    var closure: ((Bool) -> ())?
    var context = LAContext()
    var error: NSError?
    private let biometrickAuth = BiometrickAuth()
    
    //MARK: Индикаторы ввода пароля
    @IBOutlet weak var firstIndicatorView: UIView!
    @IBOutlet weak var secondIndicatorView: UIView!
    @IBOutlet weak var thirdIndicatorView: UIView!
    @IBOutlet weak var fourIndicatorView: UIView!
    @IBOutlet weak var fiveIndicatorView: UIView!
    @IBOutlet weak var sixIndicatorView: UIView!
    
    //MARK: Constraints
    @IBOutlet weak var centerConstraintNumberpadStackView: NSLayoutConstraint!
    
    //MARK: Кнопки цифровой клавиатуры
    @IBOutlet weak var oneNumberButton: CustomButton!
    @IBOutlet weak var twoNumberButton: CustomButton!
    @IBOutlet weak var threeNumberButton: CustomButton!
    @IBOutlet weak var fourNumberButton: CustomButton!
    @IBOutlet weak var fiveNumberButton: CustomButton!
    @IBOutlet weak var sixNumberButton: CustomButton!
    @IBOutlet weak var sevenNumberButton: CustomButton!
    @IBOutlet weak var eightNumberButton: CustomButton!
    @IBOutlet weak var nineNumberButton: CustomButton!
    @IBOutlet weak var zeroNumberButton: CustomButton!
    
    //MARK: IBOutlets
    @IBOutlet weak var deleteSymbolCloseScreenButton: UIButton! {
        didSet {
            deleteSymbolCloseScreenButton.isHidden = UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true
        }
    }
    @IBOutlet weak var touchFaceIDButton: CustomButton! {
        didSet {
            touchFaceIDButton.setImage(biometrickAuth.getimageForBiometrickType(), for: .normal)
        }
    }
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context.localizedCancelTitle = "Отмена"
        if !(UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true) {
            showBiomentricAutorization()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true {
            topImage.image = UIImage(named: "key")
            topTextLabel.text = """
                              Перед началом, задайте код-пароль.
                              Для чего? Расскажу дальше 😉
                              """
            touchFaceIDButton.isHidden = true
        } else {
            topImage.image = UIImage(systemName: "lock.fill")
            topTextLabel.text = "Введите код-пароль"
            touchFaceIDButton.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        if password == "" {
            //MARK: Настройка индикаторов ввода пароля
            //Скругление
            firstIndicatorView.layer.cornerRadius = firstIndicatorView.frame.height / 2
            secondIndicatorView.layer.cornerRadius = secondIndicatorView.frame.height / 2
            thirdIndicatorView.layer.cornerRadius = thirdIndicatorView.frame.height / 2
            fourIndicatorView.layer.cornerRadius = fourIndicatorView.frame.height / 2
            fiveIndicatorView.layer.cornerRadius = fiveIndicatorView.frame.height / 2
            sixIndicatorView.layer.cornerRadius = sixIndicatorView.frame.height / 2
            //Отрисовка границы и удаление фона
            firstIndicatorView.layer.borderWidth = 1
            firstIndicatorView.layer.borderColor = UIColor.white.cgColor
            firstIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            secondIndicatorView.layer.borderWidth = 1
            secondIndicatorView.layer.borderColor = UIColor.white.cgColor
            secondIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            thirdIndicatorView.layer.borderWidth = 1
            thirdIndicatorView.layer.borderColor = UIColor.white.cgColor
            thirdIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            fourIndicatorView.layer.borderWidth = 1
            fourIndicatorView.layer.borderColor = UIColor.white.cgColor
            fourIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            fiveIndicatorView.layer.borderWidth = 1
            fiveIndicatorView.layer.borderColor = UIColor.white.cgColor
            fiveIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            sixIndicatorView.layer.borderWidth = 1
            sixIndicatorView.layer.borderColor = UIColor.white.cgColor
            sixIndicatorView.layer.backgroundColor = UIColor.clear.cgColor
            
            //MARK: Настройка цифровой клавиатуры
            //Скругление
            oneNumberButton.layer.cornerRadius = oneNumberButton.frame.height / 2
            twoNumberButton.layer.cornerRadius = twoNumberButton.frame.height / 2
            threeNumberButton.layer.cornerRadius = threeNumberButton.frame.height / 2
            fourNumberButton.layer.cornerRadius = fourNumberButton.frame.height / 2
            fiveNumberButton.layer.cornerRadius = fiveNumberButton.frame.height / 2
            sixNumberButton.layer.cornerRadius = sixNumberButton.frame.height / 2
            sevenNumberButton.layer.cornerRadius = sevenNumberButton.frame.height / 2
            eightNumberButton.layer.cornerRadius = eightNumberButton.frame.height / 2
            nineNumberButton.layer.cornerRadius = nineNumberButton.frame.height / 2
            zeroNumberButton.layer.cornerRadius = zeroNumberButton.frame.height / 2
            
            //MARK: Установка вертикального положения цифровой клавиатуры по-центру
            centerConstraintNumberpadStackView.constant = -zeroNumberButton.frame.height / 2
            //self.view.layoutIfNeeded()
        }
        if password.count > 0 {
            deleteSymbolCloseScreenButton.titleLabel?.text = "Удалить"
        } else if password.count == 0 && UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true {
            deleteSymbolCloseScreenButton.titleLabel?.text = "Закрыть"
        }
    }
    
    //MARK: кнопка удаления символа пароля/закрытия окна ввода пароля
    @IBAction func bottomButton(_ sender: UIButton) {
        
        if password == "" {
            dismiss(animated: true)
        } else {
            password = String(password.dropLast())
            switch password.count{
                case 0:
                    firstIndicatorView.backgroundColor = .clear
                    break;
                case 1:
                    secondIndicatorView.backgroundColor = .clear
                    break;
                case 2:
                    thirdIndicatorView.backgroundColor = .clear
                    break;
                case 3:
                    fourIndicatorView.backgroundColor = .clear
                    break;
                case 4:
                    fiveIndicatorView.backgroundColor = .clear
                    break;
                case 5:
                    sixIndicatorView.backgroundColor = .clear
                    break;
                default:
                    return
            }
        }
        
        
        deleteSymbolCloseScreenButton.isHidden = password.count <= 0 && UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true
        
    }
    
    //MARK: Вызов Touch/Face ID
    @IBAction func touchFaceIdButtonAction(_ sender: CustomButton) {
        showBiomentricAutorization()
    }
    
    /// Вызов авторизации через Touch или Face ID
    private func showBiomentricAutorization() {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Отмена вызова") { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.closure?(true)
                        self.dismiss(animated: true)
                    }
                } else {
                    print("Ошибка авторизации через биометрию")
                }
            }
        }
    }
    
    
    //MARK: Обработка нажатия кнопок на цифровой клавиатуре
    @IBAction func firstNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func secondNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func thirdNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func fourNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func fiveNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func sixNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func sevenNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func eightNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func nineNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    @IBAction func zeroNumberButtonAction(_ sender: CustomButton) {
        checkPassword(btn: sender)
    }
    
    
    /// Функция проверки введенного пароля
    /// - Parameter btn: числовая кнопка, которая была нажата
    private func checkPassword(btn: CustomButton) {
        
        switch password.count {
            case 0:
                password += (btn.titleLabel?.text)!
                firstIndicatorView.backgroundColor = .white
                break;
            case 1:
                password += (btn.titleLabel?.text)!
                secondIndicatorView.backgroundColor = .white
                break;
            case 2:
                password += (btn.titleLabel?.text)!
                thirdIndicatorView.backgroundColor = .white
                break;
            case 3:
                password += (btn.titleLabel?.text)!
                fourIndicatorView.backgroundColor = .white
                break;
            case 4:
                password += (btn.titleLabel?.text)!
                fiveIndicatorView.backgroundColor = .white
                break;
            case 5:
                password += (btn.titleLabel?.text)!
                sixIndicatorView.backgroundColor = .white
                break;
            default:
                return
        }
        
        deleteSymbolCloseScreenButton.titleLabel?.text = "Удалить"
        
        if UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true && password.count == 6 {
            UserDefaults.standard.set(password, forKey: "localPassword")
            dismiss(animated: true)
        } else if password == UserDefaults.standard.string(forKey: "localPassword") {
            closure?(true)
            dismiss(animated: true)
        }
        
        deleteSymbolCloseScreenButton.isHidden = password.count <= 0 && UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true
        
        if password.count == 6 && password != UserDefaults.standard.string(forKey: "localPassword")  {
            password = ""
            firstIndicatorView.backgroundColor = .clear
            secondIndicatorView.backgroundColor = .clear
            thirdIndicatorView.backgroundColor = .clear
            fourIndicatorView.backgroundColor = .clear
            fiveIndicatorView.backgroundColor = .clear
            sixIndicatorView.backgroundColor = .clear
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
