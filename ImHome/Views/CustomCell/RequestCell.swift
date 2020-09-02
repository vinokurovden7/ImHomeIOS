//
//  RequestCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

/// Кастомный класс ячейки из раздела запросов
class RequestCell: UITableViewCell {
    
    //MARK: Constraints
    @IBOutlet weak var rightStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftStackConstraint: NSLayoutConstraint!
    //MARK: Кнопка отмены
    @IBOutlet weak var declineButton: UIButton!
    //MARK: Кнопка добавления
    @IBOutlet weak var acceptButton: UIButton!
    //MARK: Стек с кнопками
    @IBOutlet weak var buttonStack: UIStackView!
    //MARK: Главное фоновое view
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var nameContactLabel: UILabel!
    @IBOutlet weak var emailContactLabel: UILabel!
    @IBOutlet weak var staticMessageLabel: UILabel!
    //MARK: View подложка под изображение для добавления тени
    @IBOutlet weak var backImageRequestView: UIView! {
        didSet {
            backImageRequestView.layer.cornerRadius = backImageRequestView.frame.height / 2
            backImageRequestView.layer.shadowRadius = 4
            backImageRequestView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backImageRequestView.layer.shadowOpacity = 0.7
            backImageRequestView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    //MARK: Изображение контакта
    @IBOutlet weak var imageRequest: UIImageView! {
        didSet {
            imageRequest.layer.cornerRadius = imageRequest.frame.height / 2
            imageRequest.layer.borderColor = UIColor.white.cgColor
            imageRequest.layer.borderWidth = 2
            imageRequest.clipsToBounds = true
        }
    }
    

}
