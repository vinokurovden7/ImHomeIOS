//
//  ViewController.swift
//  I'm home
//
//  Created by Денис Винокуров on 12.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Variables
    private let keychain = Keychain()
    private let nameAccount = "Home"
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "localPassword")?.isEmpty ?? true {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "setLocalPassword", sender: self)
            }
        } else if !UserDefaults.standard.bool(forKey: "presentationWasViewed") {
            keychain.removeKey(userAccount: nameAccount)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showPresentation", sender: self)
            }
        } else {
            checkLoginData()
        }
    }
    
    func checkLoginData() {
        if let _ = keychain.getKey(userAccount: nameAccount) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "skipLoginScreen", sender: self)
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showLoginScreen", sender: self)
            }
        }
    }

    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
