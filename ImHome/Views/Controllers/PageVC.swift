//
//  PageVC.swift
//  ImHome
//
//  Created by Денис Винокуров on 14.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    let screenContent = ["Первая страница", "Вторая страница", "Третья страница"]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let contentViewController = showFuncViewControllerAtIndex(0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showFuncViewControllerAtIndex(_ index: Int) -> ContentVC? {
        guard index >= 0 else {return nil}
        guard index < screenContent.count else {return nil}
        guard let contentViewController = storyboard?.instantiateViewController(identifier: "ContentVC") as? ContentVC else {return nil}
        
        contentViewController.textForLabel = screenContent[index]
        contentViewController.currentPage = index
        contentViewController.totalPages = screenContent.count
        if index == contentViewController.totalPages - 1 {
            contentViewController.hideClosePresentationBtn = false
        } else {
            contentViewController.hideClosePresentationBtn = true
        }
        
        return contentViewController
    }

}

extension PageVC: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentVC).currentPage
        pageNumber -= 1
        
        return showFuncViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! ContentVC).currentPage
        pageNumber += 1
        
        return showFuncViewControllerAtIndex(pageNumber)
    }
    
    
}
