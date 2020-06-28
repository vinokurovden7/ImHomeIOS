//
//  NewContactCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 26.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

/// Кастомный класс ячейки нового контакта
class NewContactCell: UITableViewCell {

    //MARK: View подложка под изображение для добавления тени
    @IBOutlet weak var backgroundViewNewContactImage: UIView! {
        didSet {
            backgroundViewNewContactImage.layer.cornerRadius = backgroundViewNewContactImage.frame.height / 2
            backgroundViewNewContactImage.layer.shadowRadius = 4
            backgroundViewNewContactImage.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewNewContactImage.layer.shadowOpacity = 0.7
            backgroundViewNewContactImage.layer.shadowColor = UIColor.black.cgColor
        }
    }
    //MARK: Изображение контакта
    @IBOutlet weak var newContactImage: UIImageView! {
        didSet {
            newContactImage.layer.cornerRadius = newContactImage.frame.height / 2
            newContactImage.layer.borderColor = UIColor.white.cgColor
            newContactImage.layer.borderWidth = 2
        }
    }
    
}
