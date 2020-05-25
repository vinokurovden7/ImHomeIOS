//
//  DelayMessageVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 25.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class DelayMessageVC: UIViewController {

    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var sendMessageBtn: UIButton! {
        didSet {
            sendMessageBtn.layer.cornerRadius = sendMessageBtn.frame.height / 2
        }
    }
    @IBOutlet weak var delayTextField: UITextField! {
        didSet {
            delayTextField.layer.cornerRadius = delayTextField.frame.height / 2
            delayTextField.clipsToBounds = true
            delayTextField.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
