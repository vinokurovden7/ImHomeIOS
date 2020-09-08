//
//  AddedContactVC.swift
//  ImHome
//
//  Created by Денис Винокуров on 04.08.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class AddedContactVC: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonAddContact: CustomButton!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var imageContact: UIImageView! {
        didSet {
            imageContact.layer.cornerRadius = imageContact.frame.height / 2
            imageContact.layer.borderWidth = 2
            imageContact.layer.borderColor = UIColor.white.cgColor
            imageContact.clipsToBounds = true
        }
    }
    @IBOutlet weak var backgroundViewContactImage: UIView! {
        didSet {
            backgroundViewContactImage.layer.cornerRadius = backgroundViewContactImage.frame.height / 2
            backgroundViewContactImage.layer.shadowRadius = 4
            backgroundViewContactImage.layer.shadowOffset = CGSize(width: 0, height: 3)
            backgroundViewContactImage.layer.shadowOpacity = 1
            backgroundViewContactImage.layer.shadowColor = UIColor.black.cgColor
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Наблюдатель появления и скрытия клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: Обработчик появления клавиатуры
    @objc func keyboardWasShown(_ notification: Notification) {
        if self.messageTextView.isEditable {
            let keyboardInfo  = notification.userInfo as NSDictionary?
            let keyboardFrameEnd: NSValue? = (keyboardInfo?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)
            let keyboardFrameEndRect: CGRect? = keyboardFrameEnd?.cgRectValue
            UIView.animate(withDuration: 0.3, delay: 0, options: .transitionFlipFromTop, animations: {() -> Void in
                self.bottomConstraint.constant = (self.messageTextView.frame.origin.y + self.messageTextView.frame.size.height - (keyboardFrameEndRect?.origin.y)!) + 70.0
                self.view.layoutIfNeeded()
            }, completion: {(_ finished: Bool) -> Void in
                
            })
        }
    }

    //MARK: Обработчик скрытия клавиатуры
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.topConstraint.constant = 10
            self.bottomConstraint.constant = 10
            self.view.layoutIfNeeded()
            
        })
    }

}
