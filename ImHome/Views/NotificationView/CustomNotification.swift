//
//  CustomNotification.swift
//  ImHome
//
//  Created by Денис Винокуров on 12.06.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import SwiftEntryKit

/// Кастомные уведомления библиотеки SwiftEntryKit
class CustomNotification {
    
    //static let sharedCustomNotification = CustomNotification()
    
    //MARK: Атрибуты для уведомления с текстом
    ///Атрибуты для уведомления с текстом
    private var floatAlertAttributes: EKAttributes {
        var attributes = EKAttributes.topFloat
        attributes.hapticFeedbackType = .none
        attributes.displayDuration = .infinity
        attributes.statusBar = .light
        attributes.entryBackground = .color(color: EKColor(UIColor(named: "rombColor")!))
        attributes.screenBackground = .color(color: EKColor(UIColor(named: "notifFonColor")!))
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(
            swipeable: true,
            pullbackAnimation: .jolt
        )
        attributes.roundCorners = .all(radius: 25)
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.4,
                spring: .init(damping: 0.5, initialVelocity: 0)
            ),
            scale: .init(
                from: 1.05,
                to: 1,
                duration: 0.2,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(
            width: .offset(value: 20),
            height: .intrinsic
        )
        attributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.bounds.width),
            height: .intrinsic
        )
        return attributes
    }
    
    //MARK: Функция уведомления с текстом
    /// Функция уведомления с текстом
    /// - Parameters:
    ///   - title: Заголовок
    ///   - desc: Основной текст уведомления
    ///   - textColor: Цвет текста уведомления
    ///   - imageColor: Цвет картинки уведомления
    ///   - imageName: Название изображения
    /// - Returns: Уведомление
    private func getFloatContentView(title: String, desc: String, textColor: EKColor, imageColor: EKColor?, imageName: String? = nil) -> EKNotificationMessageView {
        let title = EKProperty.LabelContent(
            text: title,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: textColor,
                displayMode: .inferred
            ),
            accessibilityIdentifier: "title"
        )
        let description = EKProperty.LabelContent(
            text: desc,
            style: .init(
                font: UIFont.systemFont(ofSize: 16),
                color: textColor,
                displayMode: .inferred
            ),
            accessibilityIdentifier: "description"
        )
        var image: EKProperty.ImageContent?
        if let imageName = imageName {
            image = EKProperty.ImageContent(
                image: (UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) ?? UIImage(systemName: imageName)) ?? UIImage(),
                displayMode: .inferred,
                size: CGSize(width: 35, height: 35),
                tint: imageColor ?? textColor,
                accessibilityIdentifier: "thumbnail"
            )
        }
        let simpleMessage = EKSimpleMessage(
            image: image,
            title: title,
            description: description
        )
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        return EKNotificationMessageView(with: notificationMessage)
    }
    
    //MARK: Системное уведомление
    /// Системное уведомление
    /// - Parameter text: Текст уведомления
    /// - Returns: Уведомление
    private func smallNotifContentView(text: String) -> EKNoteMessageView{
        let text = text
        let style = EKProperty.LabelStyle(
            font: UIFont.systemFont(ofSize: 14),
            color: .white,
            alignment: .center
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        return EKNoteMessageView(with: labelContent)
    }
    
    /// Получить атрибуты системного уведомления
    /// - Parameter color: Цвет
    /// - Returns: Атрибуты
    private func getSmallNotificationAttributes(color: UIColor) -> EKAttributes {
        var noteAttributes = EKAttributes.topNote
        noteAttributes.displayMode = EKAttributes.DisplayMode.inferred
        noteAttributes.hapticFeedbackType = .none
        noteAttributes.popBehavior = .animated(animation: .translation)
        noteAttributes.entryBackground = .color(color: EKColor(color))
        noteAttributes.shadow = .none
        noteAttributes.statusBar = .light
        noteAttributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.2,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        noteAttributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        noteAttributes.displayDuration = 0.5
        return noteAttributes
    }
    
    /// Показ  уведомления
    /// - Parameters:
    ///   - title: Заголовок
    ///   - message: Текст сообщения
    ///   - image: Название картинки
    func showNotification(title: String, message: String, imageColor: UIColor? ,image: String?){
        let contentView = getFloatContentView(title: title, desc: message, textColor: EKColor(UIColor(named: "notifTextViewColor")!), imageColor: EKColor(imageColor ?? UIColor.systemRed), imageName: image ?? "exclamationmark.triangle.fill")
        DispatchQueue.main.async {
            SwiftEntryKit.display(entry: contentView, using: self.floatAlertAttributes)
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }
    }
    
    /// Мини уведомление
    /// - Parameters:
    ///   - text: Текст сообщения
    ///   - color: Цвет сообщения
    func miniNotification(text: String, color: UIColor) {
        SwiftEntryKit.display(entry: smallNotifContentView(text: text), using: getSmallNotificationAttributes(color: color))
    }
}
