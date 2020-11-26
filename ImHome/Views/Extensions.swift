//
//  Extensions.swift
//  ImHome
//
//  Created by Денис Винокуров on 09.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
extension UIView {
    func animateBorderWidth(toValue: CGFloat, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }
    func animateBorderColor(toValue: CGColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Color")
        layer.borderColor = toValue
    }
}

extension UIImage {

    enum JPEGQuality: CGFloat {
            case lowest  = 0
            case low     = 0.25
            case medium  = 0.5
            case high    = 0.75
            case highest = 1
        }

    /// Возвращает данные для указанного изображения в формате JPEG.
    /// Если базовые данные изображения объекта изображения были удалены, вызов этой функции заставляет эти данные быть перезагруженными в память.
    /// - returns: Объект данных, содержащий данные JPEG, или ноль, если возникла проблема с генерацией данных. Эта функция может возвращать ноль, если изображение не содержит данных или если базовый CGImageRef содержит данные в неподдерживаемом растровом формате.
    func jpegData(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}

extension UINavigationController {
    func setupNavigationController(navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.barStyle = .black
    }
}
