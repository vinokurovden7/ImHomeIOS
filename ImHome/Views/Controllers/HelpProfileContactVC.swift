//
//  HelpProfileContactVC.swift
//  ImHome
//
//  Created by Денис Винокуров on 29.06.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class HelpProfileContactVC: UIViewController {
    
    @IBOutlet weak var imageContact: UIImageView! {
        didSet {
            imageContact.layer.cornerRadius = 20
            imageContact.layer.borderWidth = 2
            imageContact.layer.borderColor = UIColor.white.cgColor
            imageContact.clipsToBounds = true
        }
    }
    @IBOutlet weak var backgroundViewContactImage: UIView! {
        didSet {
            backgroundViewContactImage.layer.cornerRadius = 20
            backgroundViewContactImage.layer.shadowRadius = 4
            backgroundViewContactImage.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewContactImage.layer.shadowOpacity = 1
            backgroundViewContactImage.layer.shadowColor = UIColor.black.cgColor
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

}
