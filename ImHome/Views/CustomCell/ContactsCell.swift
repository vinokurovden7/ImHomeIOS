//
//  ContactsCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit



/// Кастомный класс ячейки из раздела контактов
class ContactsCell: UICollectionViewCell {
    @IBOutlet weak var nameContact: UILabel!
    @IBOutlet weak var emailContact: UILabel!
    @IBOutlet weak var micButton: UIImageView!
    @IBOutlet weak var mapButton: UIImageView!
    @IBOutlet weak var messageButton: UIImageView!
    //MARK: Фоновое View ячейки
    @IBOutlet weak var backgroundViewContacts: UIView!
    //MARK: Constraint ширины ячейки для динамического изменения
    @IBOutlet weak var widthConstraintPlit: NSLayoutConstraint!
    //MARK: View подложка под изображение для наложения тени
    @IBOutlet weak var backImageContactView: UIView! {
        didSet {
            backImageContactView.layer.cornerRadius = backImageContactView.frame.height / 2
            backImageContactView.layer.shadowRadius = 4
            backImageContactView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backImageContactView.layer.shadowOpacity = 0.7
            backImageContactView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    //MARK: Изображение контакта
    @IBOutlet var imageContact: UIImageView! {
        didSet {
            imageContact.layer.cornerRadius = imageContact.frame.height / 2
            imageContact.layer.borderWidth = 2
            imageContact.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    weak var viewModel: ContactsCellDelegate? {
        willSet(viewModel){
            guard let viewModel = viewModel else {return}
            nameContact.text = viewModel.nameContact
            emailContact.text = viewModel.emailContact
            imageContact.image = viewModel.imageContact
            switch viewModel.statusContact {
            case 0:
                backgroundViewContacts.backgroundColor = UIColor(named: "viewPlitsColor")
            case 1:
                backImageContactView.backgroundColor = .systemOrange
            case 2:
                backImageContactView.backgroundColor = .systemRed
            default:
                backImageContactView.backgroundColor = UIColor(named: "viewPlitsColor")
            }
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
    
    
    
}
