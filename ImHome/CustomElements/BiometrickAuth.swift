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
    
    /// Получение изображения для кнопки относительно типа биометрии
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
}
