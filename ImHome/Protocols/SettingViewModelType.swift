//
//  SettingViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 26.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol SettingViewModelType {
    func setTimeCancelSosSignal(time: String)
    func getTimeCancelSosSignal() -> String
    func setUseBiometrick(using: Bool)
    func getUseBiometrick() -> Bool
    func getPhotoAccount() -> UIImage
    func getFioAccount() -> String
    func getEmailAccount() -> String
}
