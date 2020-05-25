//
//  ContactsCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ContactsCell: UICollectionViewCell {
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
    
}
