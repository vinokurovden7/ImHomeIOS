//
//  MainVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var mainTimerTimeLabel: UILabel! {
        didSet {
            mainTimerTimeLabel.isHidden = true
        }
    }
    @IBOutlet weak var messageTimerTimeLabel: UILabel! {
        didSet {
            messageTimerTimeLabel.isHidden = true
        }
    }
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var delayMessageButton: CustomButton!
    @IBOutlet weak var cancelAlarm: UIButton! {
        didSet {
            cancelAlarm.isHidden = true
        }
    }
    
    //MARK: Variables
    var sec = 10
    var hour = 0
    var minutes = 0
    private var pressedMainButton = false
    private var viewModel: MainViewModelType?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateInterface(notification:)), name: Notification.Name("update_timer"), object: nil)
        mainButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        mainButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        mainButton.addTarget(self, action: #selector(allEvents), for: .allEvents)
        
        viewModel = MainVM()
    }
    
    //MARK: Обработчики
    //MARK: Переход на экран отправки отложенного сообщения
    @IBAction func delayMessageBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showDelayMessageScreen", sender: self)
    }
    
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "showDelayMessageScreen":
                guard let destination = segue.destination as? DelayMessageVC else {return}
                destination.closure = { [weak self] time in
                    let timeArr = time.components(separatedBy: ":")
                    if timeArr.count == 3 {
                        self!.hour = Int(timeArr[0]) ?? 0
                        self!.minutes = Int(timeArr[1]) ?? 0
                        self!.sec = Int(timeArr[2]) ?? 0
                    } else if timeArr.count == 2 {
                        self!.minutes = Int(timeArr[0]) ?? 0
                        self!.sec = Int(timeArr[1]) ?? 0
                    } else {
                        self!.sec = Int(timeArr[0]) ?? 0
                    }
                    self!.mainTimerTimeLabel.isHidden = true
                    self!.messageTimerTimeLabel.isHidden = false
                    self!.cancelAlarm.isHidden = false
                    self!.delayMessageButton.backgroundColor = .systemOrange
                    guard let viewModel = self!.viewModel else {return}
                    viewModel.setTimer(hour: self!.hour, minutes: self!.minutes, seconds: self!.sec)
                }
            case "showLocker":
                guard let destination = segue.destination as? LockerViewController else {return}
                destination.closure = {[weak self] success in
                    if success {
                        guard let viewModel = self!.viewModel else {return}
                        viewModel.stopTimer()
                        self!.tabBarItem.badgeValue = nil
                        self!.cancelAlarm.isHidden = true
                        self!.mainTimerTimeLabel.isHidden = true
                        self!.messageTimerTimeLabel.isHidden = true
                        self!.mainButton.tintColor = .white
                        self!.delayMessageButton.backgroundColor = .white
                        self!.delayMessageButton.isEnabled = true
                        self!.pressedMainButton = false
                        self!.mainTimerTimeLabel.text = ""
                        self!.messageTimerTimeLabel.text = ""
                    }
            }
            default:
                return
        }
    }
    
    //MARK: Главная кнопка
    @IBAction func mainButton(_ sender: UIButton) {
        delayMessageButton.isEnabled = false
        sendHelpMessage()
    }
    
    //MARK: Кнопка отмены отправки сообщения
    @IBAction func cancelAlarmAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showLocker", sender: self)
    }
    
    //MARK: Функция, отвечающая за нажатие на кнопку
    @objc func touchDown(){
        if !pressedMainButton {
            mainButton.tintColor = .systemOrange
            UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
                self.mainButton.transform.a = 0.9
                self.mainButton.transform.d = 0.9
            })
        }
    }
    
    //MARK: Функция, отвечающая за любое взаимодействие с кнопкой
    @objc func allEvents(){
        mainButton.isHighlighted = false
    }

    //MARK: Функция, отвечающая за отпускание нажатой кнопки
    @objc func touchUpInside(){
        UIImpactFeedbackGenerator.init(style: .soft).impactOccurred()
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.mainButton.transform.a = 1
            self.mainButton.transform.d = 1
        })
    }
    
    //MARK: Функция, отвечающая за отведения пальца с кнопки без отпускания
    @objc func touchDragExit(){
        sendHelpMessage()
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.mainButton.transform.a = 1
            self.mainButton.transform.d = 1
        })
    }
    
    //MARK: Функция обратного отсчета и отправки сообщения о помощи
    private func sendHelpMessage(){
        if !pressedMainButton {
            delayMessageButton.backgroundColor = .white
            mainTimerTimeLabel.isHidden = false
            messageTimerTimeLabel.isHidden = true
            cancelAlarm.isHidden = false
            guard let viewModel = viewModel else {return}
            viewModel.setTimer(hour: 0, minutes: 0, seconds: 10)
        }
        pressedMainButton = true
    }
    
    //MARK: Функция обработки обновления таймера (слушатель таймера)
    @objc func updateInterface(notification: Notification) {
        if let userInfo = notification.userInfo as? [String: [String]]
        {
            if let date = userInfo["time"] {
                guard let viewModel = viewModel else {return}
                let dateString = viewModel.getTimeString(date: date)
                if dateString == "!!!" {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                    if !mainTimerTimeLabel.isHidden {
                        self.mainButton.tintColor = .systemRed
                    } else {
                        self.delayMessageButton.backgroundColor = .systemRed
                    }
                    self.tabBarItem.badgeValue = dateString
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                    self.mainTimerTimeLabel.isHidden = true
                    self.messageTimerTimeLabel.isHidden = true
                } else {
                    self.tabBarItem.badgeValue = dateString
                    self.mainTimerTimeLabel.text = dateString
                    self.messageTimerTimeLabel.text = dateString
                }
            }
        }
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
