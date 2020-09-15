//
//  CustomTimer.swift
//  ImHome
//
//  Created by Денис Винокуров on 04.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation

class CustomTimer {

    //MARK: Переменные
    var timer: Timer?
    private var hour = 0
    private var minutes = 0
    private var seconds = 0

    /// Запуск таймера
    /// - Parameters:
    ///   - hour: часы
    ///   - minutes: минуты
    ///   - seconds: секунды
    func createTimer(hour: Int, minutes: Int, seconds: Int) {
        stopTimer()
        self.hour = hour
        self.minutes = minutes
        self.seconds = seconds
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
    @objc private func updateTimer() {
        var times: [String] = []
        if hour > 0 {
            if minutes > 0 {
                if seconds > 0 {
                    seconds -= 1
                } else if seconds == 0 {
                    seconds = 59
                    minutes -= 1
                }
            } else if minutes == 0 {
                if hour > 0 {
                    minutes = 59
                }
                seconds = 59
                hour -= 1
            }
        } else {
            if minutes > 0 {
                if seconds > 0 {
                    seconds -= 1
                } else if seconds == 0 {
                    seconds = 59
                    minutes -= 1
                }
            } else if minutes == 0 {
                if seconds > 0 {
                    seconds -= 1
                }
            }
        }
        
        if seconds == 0 && hour == 0 && minutes == 0 {
            timer?.invalidate()
            timer = nil
        } else {
            if hour > 0 {
                if hour < 10 {
                    times.append("0\(hour)")
                } else {
                    times.append("\(hour)")
                }
            }
            if minutes > 0 || hour > 0 {
                if minutes < 10 {
                    times.append("0\(minutes)")
                } else {
                    times.append("\(minutes)")
                }
            }
            if seconds < 10  && (hour > 0 || minutes > 0){
                times.append("0\(seconds)")
            } else {
                times.append("\(seconds)")
            }
            
        }
        
        if seconds == -1 {
            stopTimer()
        } else {
            let dataDict:[String: [String]] = ["time": times]
            NotificationCenter.default.post(name: Notification.Name("update_timer"), object: nil, userInfo: dataDict)
        }
    }
    
    /// Остановка таймера
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        self.hour = 0
        self.minutes = 0
        self.seconds = 0
    }
    
}
