//
//  MainVC.swift
//  I'm home
//
//  Created by Денис Винокуров on 22.05.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Обработчики
    @IBAction func delayMessageBtnAction(_ sender: CustomButton) {
        performSegue(withIdentifier: "showDelayMessageScreen", sender: self)
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}
