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
    @IBOutlet weak var cancelAlarm: UIButton! {
        didSet {
            cancelAlarm.isHidden = true
        }
    }
    
    //MARK: Variables
    private var sec: Int?
    private var pressedMainButton = false
    
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
                    self!.messageTimerTimeLabel.text = time
                    self!.messageTimerTimeLabel.isHidden = false
                    self!.cancelAlarm.isHidden = false
                }
            default:
                return
        }
    }
    
    //MARK: Главная кнопка
    @IBAction func mainButton(_ sender: UIButton) {
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
            mainTimerTimeLabel.isHidden = false
            self.sec = 10
            self.mainTimerTimeLabel.text = "\(self.sec!) c"
            self.tabBarItem.badgeValue = "\(self.sec!)"
            cancelAlarm.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                DispatchQueue.main.async {
                    if self.sec! > -1 {
                        self.tabBarItem.badgeValue = "\(self.sec!)"
                        self.mainTimerTimeLabel.text = "\(self.sec!) c"
                    }
                }
                if self.sec! <= 0 {
                    if self.sec != -1 {
                        UINotificationFeedbackGenerator().notificationOccurred(.error)
                        self.mainButton.tintColor = .systemRed
                        self.tabBarItem.badgeValue = "!!!"
                        self.mainTimerTimeLabel.isHidden = true
                    }
                    timer.invalidate()
                }
                if self.sec! <= 6 && self.sec! > 0 {
                    UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
                }
                self.sec! -= 1
            }
        }
        pressedMainButton = true
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
