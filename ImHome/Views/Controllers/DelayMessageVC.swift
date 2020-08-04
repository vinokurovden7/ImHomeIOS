//
//  DelayMessageVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 25.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class DelayMessageVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var timePickerView: UIPickerView = UIPickerView()

    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var heightConstraintMessageTextView: NSLayoutConstraint!
    @IBOutlet weak var sendMessageBtn: UIButton! {
        didSet {
            sendMessageBtn.layer.cornerRadius = sendMessageBtn.frame.height / 2
        }
    }
    @IBOutlet weak var delayTextField: UITextField! {
        didSet {
            delayTextField.layer.cornerRadius = delayTextField.frame.height / 2
            delayTextField.clipsToBounds = true
            delayTextField.layer.shadowColor = UIColor.black.cgColor
            delayTextField.inputView = timePickerView
        }
    }
    @IBOutlet weak var sendBtn: UIButton!
    
    //MARK: Кнопки для toolbar в pickerView
    private let doneButton = UIBarButtonItem(title: "Выбрать", style: .done, target: self, action: #selector(donePicker))
    private let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    private let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelPicker))
    private let toolBar = UIToolbar()
    
    //MARK: Variables
    var closure: ((String) -> ())?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Наблюдатель появления и скрытия клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //MARK: Setub timePickerView
        timePickerView.delegate = self
        timePickerView.dataSource = self

        setToolBarNav()
        
    }
    
    //MARK: Обработчик появления клавиатуры
    @objc func keyboardWasShown(_ notification: Notification) {
        if self.delayTextField.isEditing {
            let keyboardInfo  = notification.userInfo as NSDictionary?
            let keyboardFrameEnd: NSValue? = (keyboardInfo?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)
            let keyboardFrameEndRect: CGRect? = keyboardFrameEnd?.cgRectValue
            if delayTextField.frame.origin.y + delayTextField.frame.size.height + 30 >= (keyboardFrameEndRect?.origin.y)! {
                UIView.animate(withDuration: 0.3, delay: 0, options: .transitionFlipFromTop, animations: {() -> Void in
                    self.topConstraint.constant = -(self.delayTextField.frame.origin.y + self.delayTextField.frame.size.height - (keyboardFrameEndRect?.origin.y)!) - 50.0
                    self.bottomConstraint.constant = (self.delayTextField.frame.origin.y + self.delayTextField.frame.size.height - (keyboardFrameEndRect?.origin.y)!) + 100.0
                    self.view.layoutIfNeeded()
                }, completion: {(_ finished: Bool) -> Void in
                    
                })
            }
        } else {
            let keyboardInfo  = notification.userInfo as NSDictionary?
            let keyboardFrameEnd: NSValue? = (keyboardInfo?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)
            let keyboardFrameEndRect: CGRect? = keyboardFrameEnd?.cgRectValue
            if messageTextView.frame.origin.y + messageTextView.frame.size.height + 30 >= (keyboardFrameEndRect?.origin.y)! {
                UIView.animate(withDuration: 0.3, delay: 0, options: .transitionFlipFromTop, animations: {() -> Void in
                    self.bottomConstraint.constant = (self.delayTextField.frame.origin.y + self.delayTextField.frame.size.height - (keyboardFrameEndRect?.origin.y)!) - 15.0
                    self.view.layoutIfNeeded()
                }, completion: {(_ finished: Bool) -> Void in
                    
                })
            }
        }
    }
    
    //MARK: Обработчик скрытия клавиатуры
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.topConstraint.constant = 20
            self.bottomConstraint.constant = 20
            self.view.layoutIfNeeded()
            
        })
    }
    
    //MARK: Настройки navigationController и toolbar-а у pickerView
    /// Настройки navigationController и toolbar-а у pickerView
    func setToolBarNav() {
        toolBar.barStyle = .default
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        doneButton.tintColor = .systemBlue
        cancelButton.tintColor = .systemRed
        delayTextField.inputAccessoryView = toolBar
    }
    
    //MARK: Обработчик кнопки Выбрать в picker
    @objc func donePicker(){
        
        var hours: String = ""
        var minutes: String = ""
        var seconds: String = ""
        //Форматирование вывода времени
        if timePickerView.selectedRow(inComponent: 0) != 0 {
            if timePickerView.selectedRow(inComponent: 0) < 10 {
                hours = "0\(timePickerView.selectedRow(inComponent: 0))"
            } else {
                hours = "\(timePickerView.selectedRow(inComponent: 0))"
            }
            if timePickerView.selectedRow(inComponent: 1) < 10 {
                minutes = "0\(timePickerView.selectedRow(inComponent: 1))"
            } else {
                minutes = "\(timePickerView.selectedRow(inComponent: 1))"
            }
            if timePickerView.selectedRow(inComponent: 2) < 10 {
                seconds = "0\(timePickerView.selectedRow(inComponent: 2))"
            } else {
                seconds = "\(timePickerView.selectedRow(inComponent: 2))"
            }
            delayTextField.text = "\(hours):\(minutes):\(seconds)"
        } else {
            if timePickerView.selectedRow(inComponent: 1) < 10 {
                minutes = "0\(timePickerView.selectedRow(inComponent: 1))"
            } else {
                minutes = "\(timePickerView.selectedRow(inComponent: 1))"
            }
            if timePickerView.selectedRow(inComponent: 2) < 10 {
                seconds = "0\(timePickerView.selectedRow(inComponent: 2))"
            } else {
                seconds = "\(timePickerView.selectedRow(inComponent: 2))"
            }
            delayTextField.text = "\(minutes):\(seconds)"
        }
        self.view.endEditing(true)
    }
    
    //MARK: Обработчик кнопки Отмена в picker
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
    
    //MARK: Отправка отложенного сообщения
    @IBAction func sendBtnAction(_ sender: CustomButton) {
        closure?(delayTextField.text ?? "")
        dismiss(animated: true)
    }
    
    //MARK: Функция конвертирования часы в секунды
    func convertHourSeconds(hour: Int, minutes: Int) -> Int {
        return hour*120
    }
    
    //MARK: Функция конвертирования минут в секунды
    func convertMinutesSeconds(hour: Int, minutes: Int) -> Int {
        return minutes*60
    }
}
//Расширение для PickerView
extension DelayMessageVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return 24
            case 1:
                return 60
            default:
                return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var pickerData: [String] = []
        if component == 1 {
            for i in 0...60 {
                pickerData.append("\(i)м")
            }
        } else if component == 2 {
            for i in 0...60 {
                pickerData.append("\(i)с")
            }
        } else {
            for i in 0...24 {
                pickerData.append("\(i)ч")
            }
        }
        return pickerData[row]
    }
    
}
