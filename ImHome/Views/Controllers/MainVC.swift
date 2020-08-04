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
    private var sec = 10
    var hour = 0
    var minutes = 0
    private var pressedMainButton = false
    var timer: Timer?
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        mainButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        mainButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        mainButton.addTarget(self, action: #selector(allEvents), for: .allEvents)
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
                    var times: [String] = []
                    let timeArr = time.components(separatedBy: ":")
                    if timeArr.count == 3 {
                        self!.hour = Int(timeArr[0]) ?? 0
                        self!.minutes = Int(timeArr[1]) ?? 0
                        self!.sec = Int(timeArr[2]) ?? 0
                    } else if timeArr.count == 2{
                        self!.minutes = Int(timeArr[0]) ?? 0
                        self!.sec = Int(timeArr[1]) ?? 0
                    } else {
                        self!.sec = Int(timeArr[0]) ?? 0
                    }
                    if self!.hour > 0 {
                        times.append("\(self!.hour)ч")
                    }
                    if self!.minutes > 0 || self!.hour > 0 {
                      times.append("\(self!.minutes)м")
                    }
                    times.append("\(self!.sec)с")
                    self!.messageTimerTimeLabel.text = times.joined(separator: " ")
                    self!.mainTimerTimeLabel.text = times.joined(separator: " ")
                    self!.mainTimerTimeLabel.isHidden = true
                    self!.messageTimerTimeLabel.isHidden = false
                    self!.cancelAlarm.isHidden = false
                    self!.delayMessageButton.backgroundColor = .systemOrange
                    self!.createTimer()
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
        self.tabBarItem.badgeValue = nil
        self.sec = -1
        cancelAlarm.isHidden = true
        mainTimerTimeLabel.isHidden = true
        messageTimerTimeLabel.isHidden = true
        mainButton.tintColor = .white
        delayMessageButton.backgroundColor = .white
        delayMessageButton.isEnabled = true
        pressedMainButton = false
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
            hour = 0
            minutes = 0
            sec = 10
            var times: [String] = []
            if hour > 0 {
              times.append("\(hour)ч")
            }
            if minutes > 0 {
              times.append("\(minutes)м")
            }
            times.append("\(sec)с")
            if sec <= 5 && sec > 0 && minutes == 0 && hour == 0 {
                UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
            }
            self.tabBarItem.badgeValue = times.joined(separator: " ")
            self.mainTimerTimeLabel.text = times.joined(separator: " ")
            cancelAlarm.isHidden = false
            createTimer()
        }
        pressedMainButton = true
    }
    
    //MARK: Создание таймера
    func createTimer() {
        timer?.invalidate()
        timer = nil
      if timer == nil {
        let timer = Timer(timeInterval: 1.0,
          target: self,
          selector: #selector(updateTimer),
          userInfo: nil,
          repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.timer = timer
      }
    }
    
    //MARK: Функция таймера
    @objc func updateTimer() {
        var times: [String] = []
        if hour > 0 {
            if minutes > 0 {
                if sec > 0 {
                    sec -= 1
                } else if sec == 0 {
                    sec = 59
                    minutes -= 1
                }
            } else if minutes == 0 {
                if hour > 0 {
                    minutes = 59
                }
                sec = 59
                hour -= 1
            }
        } else {
            if minutes > 0 {
                if sec > 0 {
                    sec -= 1
                } else if sec == 0 {
                    sec = 59
                    minutes -= 1
                }
            } else if minutes == 0 {
                if sec > 0 {
                    sec -= 1
                }
            }
        }
        
        if sec == 0 && hour == 0 && minutes == 0 {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            if !mainTimerTimeLabel.isHidden {
                self.mainButton.tintColor = .systemRed
            } else {
                self.delayMessageButton.backgroundColor = .systemRed
            }
            self.tabBarItem.badgeValue = "!!!"
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            self.mainTimerTimeLabel.isHidden = true
            self.messageTimerTimeLabel.isHidden = true
            timer?.invalidate()
            timer = nil
        } else {
            if hour > 0 {
              times.append("\(hour)ч")
            }
            if minutes > 0 || hour > 0 {
              times.append("\(minutes)м")
            }
            times.append("\(sec)с")
            if sec <= 5 && sec > 0 && minutes == 0 && hour == 0 {
                UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
            }
            self.tabBarItem.badgeValue = times.joined(separator: " ")
            self.mainTimerTimeLabel.text = times.joined(separator: " ")
            self.messageTimerTimeLabel.text = times.joined(separator: " ")
            
        }
        
        if sec == -1 {
            self.tabBarItem.badgeValue = nil
            self.mainTimerTimeLabel.text = ""
            self.messageTimerTimeLabel.text = ""
            delayMessageButton.isEnabled = true
            timer?.invalidate()
            timer = nil
        }
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
