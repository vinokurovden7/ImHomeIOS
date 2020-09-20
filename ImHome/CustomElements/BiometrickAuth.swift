//
//  BiometrickAuth.swift
//  ImHome
//
//  Created by Денис Винокуров on 07.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//
import UIKit
import LocalAuthentication

class BiometrickAuth {
    private var context = LAContext()
    
    /// Получение изображения относительно типа биометрической аутентификации
    /// - Returns: Изображение
    func getimageForBiometrickType() -> UIImage {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
            case .faceID:
                return UIImage.init(systemName: "faceid")!
            case .touchID:
                return UIImage.init(named: "touchID")!
            default:
                return UIImage()
        }
    }
    
    /// Получение названия относительно типа биометрической аутентификации
    /// - Returns: Название в виде строки
    func getStringForBiometrickType() -> String {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
            case .faceID:
                return "Face ID"
            case .touchID:
                return "Touch ID"
            default:
                return "Undefined biometrick system"
        }
    }
    
    /// Получение типа биометрической аутентификации
    /// - Returns: Тип биометрической аутентификации
    func getBiometrickType() -> LABiometryType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }
}
