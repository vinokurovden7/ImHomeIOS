//
//  CustomNavigationViewController.swift
//  I'm home
//
//  Created by Денис Винокуров on 02.06.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

/// Класс кастомного NavigationController, устанавливающий светлый цвет
class CustomNavigationViewController: UINavigationController {
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
}
