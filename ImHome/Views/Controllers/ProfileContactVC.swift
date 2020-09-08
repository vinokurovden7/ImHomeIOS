//
//  ProfileContactVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 25.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ProfileContactVC: UIViewController {
    
    @IBOutlet weak var nameContactLabel: UILabel! {
        didSet {
            if color == UIColor.systemOrange {
                nameContactLabel.textColor = .white
            }
        }
    }
    @IBOutlet weak var emailContactLabel: UILabel! {
        didSet {
            if color == UIColor.systemOrange {
                emailContactLabel.textColor = .white
            }
        }
    }
    @IBOutlet weak var micTextLabel: UILabel! {
        didSet {
            if color == UIColor.systemOrange {
                micTextLabel.textColor = .white
            }
        }
    }
    @IBOutlet weak var mapTextLabel: UILabel! {
        didSet {
            if color == UIColor.systemOrange {
                mapTextLabel.textColor = .white
            }
        }
    }
    var color: UIColor?
    
    //MARK: IBOutlets
    @IBOutlet weak var deletePersonBtn: UIButton! {
        didSet {
            deletePersonBtn.layer.cornerRadius = deletePersonBtn.frame.height / 2
        }
    }
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
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.backgroundColor = color ?? UIColor.init(named: "viewPlitsColor")
        }
    }
    
    //MARK: Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
