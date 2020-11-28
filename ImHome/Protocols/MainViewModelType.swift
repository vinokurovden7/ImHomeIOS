//
//  MainViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.10.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol MainViewModelType {
    func getTimeString(date: [String]) -> String
    func setTimer(hour: Int, minutes: Int, seconds: Int)
    func stopTimer()
    func showBiometrickAuth(context: LAContext, completion: @escaping (Bool) -> ())
    func getTimeCancelSosSignal() -> Int
    func parsingTime(time: String)
}
