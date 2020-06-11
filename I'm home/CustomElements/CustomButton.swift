//
//  CustomButton.swift
//  I'm home
//
//  Created by Денис Винокуров on 10.06.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

/// Класс добавляет анимированную реакцию кнопки на нажатия с виброоткликом
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(downTapped), for: .touchDown)
        self.addTarget(self, action: #selector(upInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(dragExit), for: .touchDragExit)
    }
    
    /// Функция, отвечающая за нажатие на кнопку
    @objc func downTapped(){
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            self.transform.a = 0.9
            self.transform.d = 0.9
        })
    }

    /// Функция, отвечающая за отпускание нажатой кнопки
    @objc func upInside(){
        UIImpactFeedbackGenerator.init(style: .soft).impactOccurred()
        //Haptic.softFeedback.impactOccurred()
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform.a = 1
            self.transform.d = 1
        })
    }
    
    /// Функция, отвечающая за отведения пальца с кнопки без отпускания
    @objc func dragExit(){
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform.a = 1
            self.transform.d = 1
        })
    }
}