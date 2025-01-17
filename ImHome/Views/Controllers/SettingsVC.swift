//
//  SettingsVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController, UITextFieldDelegate {

    //MARK: IBOutlets
    @IBOutlet weak var timeCancelSOSSignal: UITextField! {
        didSet {
            timeCancelSOSSignal.layer.cornerRadius = timeCancelSOSSignal.frame.height / 2
            timeCancelSOSSignal.clipsToBounds = true
        }
    }
    @IBOutlet weak var backgroundImageView: UIView! {
        didSet {
            backgroundImageView.layer.cornerRadius = backgroundImageView.frame.height / 2
            backgroundImageView.layer.shadowRadius = 4
            backgroundImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundImageView.layer.shadowOpacity = 1
            backgroundImageView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var editAccountButton: CustomButton!
    @IBOutlet weak var fioAccount: UILabel!
    @IBOutlet weak var emailAccount: UILabel!
    @IBOutlet weak var logoutAccounButton: CustomButton!
    @IBOutlet weak var profileImageVIew: UIImageView! {
        didSet {
            profileImageVIew.layer.cornerRadius = profileImageVIew.frame.width / 2
            profileImageVIew.layer.borderColor = UIColor.white.cgColor
            profileImageVIew.layer.borderWidth = 2
            profileImageVIew.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var biometrickSwitcher: UISwitch!
    
    //MARK: Variables
    private let nameAccount = "Home"
    private var viewModel: SettingViewModelType?
    private let myNotification = CustomNotification()
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsVM()
        tableView.backgroundView = UIImageView(image: UIImage(named: "fonBackground"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        tableView.backgroundView?.alpha = 0.07
        timeCancelSOSSignal.addTarget(self, action: #selector(endChangeVal), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAccountData()
    }
    
    //MARK: Обработчики
    /// Окончание изменений в поле времени отмены вызова
    @objc func endChangeVal() {
        if Int(timeCancelSOSSignal.text!) ?? 0 > 30 {
            timeCancelSOSSignal.text = "30"
        }
        guard let viewModel = viewModel else {return}
        viewModel.setTimeCancelSosSignal(time: timeCancelSOSSignal.text!)
        myNotification.miniNotification(text: "Сохранено", color: .systemGreen)
    }
    
    @IBAction func biometrickSwicherAction(_ sender: UISwitch) {
        guard let viewModel = viewModel else {return}
        viewModel.setUseBiometrick(using: sender.isOn)
        myNotification.miniNotification(text: "Сохранено", color: .systemGreen)
    }
    
    @IBAction func showPresentationAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showPresent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProfile" {
            guard let destination = segue.destination as? ProfileVC else {return}
            destination.closure = {[weak self] success in
                if success {
                    self!.performSegue(withIdentifier: "logoutAccount", sender: self)
                } else {
                    self!.getAccountData()
                }
            }
        }
    }
    
    /// Получение данных аккаунта
    private func getAccountData() {
        //let account = StorageManager().getAccount()
        guard let viewModel = viewModel else {return}
        DispatchQueue.main.async {
            self.profileImageVIew.image = viewModel.getPhotoAccount()
            self.fioAccount.text = viewModel.getFioAccount()
            self.emailAccount.text = viewModel.getEmailAccount()
            self.timeCancelSOSSignal.text = viewModel.getTimeCancelSosSignal()
            self.biometrickSwitcher.isOn = viewModel.getUseBiometrick()
        }
    }
    
    //MARK: Нажатие на любое пустое место на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //MARK: Редактирование профиля
    @IBAction func editProfileBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showProfile", sender: self)
    }
    //MARK: Выход из аккаунта
    @IBAction func logout(_ sender: CustomButton) {
        performSegue(withIdentifier: "logoutAccount", sender: self)
    }
    //MARK: Ограничение на ввод больше 2 цифр
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) ?? 0 > 0 && timeCancelSOSSignal.text?.count ?? 0 > 0 && Int(timeCancelSOSSignal.text!) ?? 0 >= 3 {
            timeCancelSOSSignal.text = "30"
        }
        if range.length + range.location > (timeCancelSOSSignal.text?.count)! {return false}
        let newLimit = (timeCancelSOSSignal.text?.count)! + string.count - range.length
        return newLimit <= 2
    }

    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
