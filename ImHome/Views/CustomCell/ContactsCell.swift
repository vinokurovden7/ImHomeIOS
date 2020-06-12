//
//  ContactsCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ContactsCell: UICollectionViewCell {
    @IBOutlet weak var backgroundViewContacts: UIView!
    @IBOutlet weak var widthConstraintPlit: NSLayoutConstraint!
    @IBOutlet weak var backImageContactView: UIView! {
        didSet {
            backImageContactView.layer.cornerRadius = backImageContactView.frame.height / 2
            backImageContactView.layer.shadowRadius = 4
            backImageContactView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backImageContactView.layer.shadowOpacity = 0.7
            backImageContactView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet var imageContact: UIImageView! {
        didSet {
            imageContact.layer.cornerRadius = imageContact.frame.height / 2
            imageContact.layer.borderWidth = 2
            imageContact.layer.borderColor = UIColor.white.cgColor
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
