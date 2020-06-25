//
//  DelayMessageVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 25.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class DelayMessageVC: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var timePickerView: UIDatePicker = UIDatePicker()

    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.layer.cornerRadius = 10
        }
    }
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Наблюдатель появления и скрытия клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        timePickerView.date = NSDate.now
        timePickerView.datePickerMode = .time

        //MARK: Настройки navigationController и toolbar-а у pickerView
        setToolBarNav()
        
    }
    
    //MARK: Обработчик появления клавиатуры
    @objc func keyboardWasShown(_ notification: Notification) {
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        delayTextField.text = dateFormatter.string(from: timePickerView.date)
        self.view.endEditing(true)
    }
    
    //MARK: Обработчик кнопки Отмена в picker
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
}
