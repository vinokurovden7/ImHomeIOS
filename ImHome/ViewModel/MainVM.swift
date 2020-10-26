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
    private var sec = 10
    private var hour = 0
    private var minutes = 0
    private let timeClass: CustomTimer
    private let biometrickAuth: BiometrickAuth
    
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
    
    init() {
        timeClass = CustomTimer()
        biometrickAuth = BiometrickAuth()
    }
}
