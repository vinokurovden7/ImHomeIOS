//
//  RequestCell.swift
//  I'm home
//
//  Created by Денис Винокуров on 23.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {
    
    @IBOutlet weak var rightStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftStackConstraint: NSLayoutConstraint!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backImageRequestView: UIView! {
        didSet {
            backImageRequestView.layer.cornerRadius = backImageRequestView.frame.height / 2
            backImageRequestView.layer.shadowRadius = 4
            backImageRequestView.layer.shadowOffset = CGSize(width: 0, height: 3)
            backImageRequestView.layer.shadowOpacity = 0.7
            backImageRequestView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var imageRequest: UIImageView! {
        didSet {
            imageRequest.layer.cornerRadius = imageRequest.frame.height / 2
            imageRequest.layer.borderColor = UIColor.white.cgColor
            imageRequest.layer.borderWidth = 2
            imageRequest.clipsToBounds = true
        }
    }
    

}
