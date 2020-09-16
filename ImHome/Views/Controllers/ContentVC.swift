//
//  ContentVC.swift
//  ImHome
//
//  Created by Денис Винокуров on 14.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var closePresentationButton: CustomButton!
    
    var textForLabel = ""
    var currentPage = 0
    var totalPages = 0
    var hideClosePresentationBtn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = textForLabel
        pageControl.numberOfPages = totalPages
        pageControl.currentPage = currentPage
    }
    @IBAction func closePresentationAction(_ sender: CustomButton) {
        UserDefaults.standard.set(true, forKey: "presentationWasViewed")
        dismiss(animated: true)
    }
    
}
