//
//  MainVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainVM: MainViewModelType {
    
    //MARK: Variables
    private var sec = 0
    private var hour = 0
    private var minutes = 0
    private let timeClass: CustomTimer
    private let biometrickAuth: BiometrickAuth
    private let storageManager = StorageManager()
    
    func getTimeString(date: [String]) -> String {
        if date.count > 0 {
            if date.count == 3 {
                self.hour = Int(date[0]) ?? 0
                self.minutes = Int(date[1]) ?? 0
                self.sec = Int(date[2]) ?? 0
            } else if date.count == 2 {
                self.minutes = Int(date[0]) ?? 0
                self.sec = Int(date[1]) ?? 0
            } else {
                self.sec = Int(date[0]) ?? 0
            }
            if sec <= 5 && sec > 0 && minutes == 0 && hour == 0 {
                UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
            }
            let dateString = date.joined(separator: ":")
            return dateString
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return "!!!"
        }
    }
    
    func setTimer(hour: Int, minutes: Int, seconds: Int) {
        timeClass.createTimer(hour: hour, minutes: minutes, seconds: seconds)
    }
    
    func stopTimer() {
        timeClass.stopTimer()
    }
    
    func showBiometrickAuth(context: LAContext, completion: @escaping (Bool) -> ()) {
        biometrickAuth.showBiomentricAutorization(context: context) { (success) in
            completion(success)
        }
    }
    
    func getTimeCancelSosSignal() -> Int {
        return storageManager.getAccount().timeCancelSosSignal
    }
    
    func parsingTime(time: String) {
        let timeArr = time.components(separatedBy: ":")
        if timeArr.count == 3 {
            hour = Int(timeArr[0]) ?? 0
            minutes = Int(timeArr[1]) ?? 0
            sec = Int(timeArr[2]) ?? 0
        } else if timeArr.count == 2 {
            minutes = Int(timeArr[0]) ?? 0
            sec = Int(timeArr[1]) ?? 0
        } else {
            sec = Int(timeArr[0]) ?? 0
        }
        setTimer(hour: hour, minutes: minutes, seconds: sec)
    }
    
    init() {
        timeClass = CustomTimer()
        biometrickAuth = BiometrickAuth()
    }
}
