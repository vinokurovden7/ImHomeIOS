//
//  NavigationViewController.swift
//  I'm home
//
//  Created by Денис Винокуров on 02.06.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            //return the status property of each VC, look at step 2
            return topVC.preferredStatusBarStyle
        }
        return .default
    }

}
