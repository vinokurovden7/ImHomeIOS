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
