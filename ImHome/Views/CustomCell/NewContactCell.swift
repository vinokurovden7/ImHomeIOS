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

    @IBOutlet weak var mainViewContactCell: UIView!
    @IBOutlet weak var nameContact: UILabel!
    @IBOutlet weak var emailContact: UILabel!

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
    
    /// Пульсирующая анимация, имитирующая нажатие
    /// - Parameters:
    ///   - animationView: view, к которому применяется анимация
    func pulseAnimate(_ animationView: UIView, completion: @escaping () -> ()){
        UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            animationView.transform.a = 0.9
            animationView.transform.d = 0.9
            UIImpactFeedbackGenerator.init(style: .soft).impactOccurred()
        }) { (_) in
            UIView.animate(withDuration: 0.12, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                animationView.transform.a = 1
                animationView.transform.d = 1
            }, completion: {(_) in
                completion()
            })

        }
    }
    
    weak var viewModel: NewContactCellDelegate? {
        willSet(viewModel){
            guard let viewModel = viewModel else {return}
            nameContact.text = viewModel.fullnameContact
            emailContact.text = viewModel.emailContact
            newContactImage.image = viewModel.photoContact
        }
    }
    
}
