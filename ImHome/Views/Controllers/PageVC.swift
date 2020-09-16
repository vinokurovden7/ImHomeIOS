//
//  PageVC.swift
//  ImHome
//
//  Created by Денис Винокуров on 14.09.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    
    var screenContent: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        screenContent = [
        """
        Итак, давай начнем!
        Пароль, который мы только что установили,
        нужен для отмены вызова о помощи,
            если вдруг будут неполадки с \(BiometrickAuth().getStringForBiometrickType()).
        """,
         """
        С паролем разобрались,
        теперь давай расскажу тебе про основные разделы и функции приложения.
        Не переживай, это быстро 😉
        """,
         """
        В приложении есть 4 раздела: главный, контакты, заявки и настройки.
        """,
         """
        В главном разделе происходит все самое интересное 😏 Именно через него можно посылать сигналы о помощи!
        Большая кнопка в центре - это твой шанс на спасение, держи ее, пока с тобой все в порядке.
        Как только почувствуешь, что нужна помощь - сразу отпускай ее и уже через считанные секунды ты сообщишь, что тебе требуется немедленная помощь.
        """,
         """
        Второй способ - это отложенные сообщения.
        В них ты указываешь любую информацию о своем нахождении или перемещении, потом указываешь время через которое отправится написанное тобой сообщение, если ты не отменишь его отправку.
        """,
        """
        Двигаемся дальше - раздел контакты.
        В нем хранятся все контакты, которым будет отправлено уведомление, что тебе нужна помощь, а также, в этом разделе можно увидеть, кому нужна помощь.
        """,
        """
        Раздел контактов изображен в виде плиток, они раскрашены в зависимости от статуса:
        Красный 🔴 - требуется помощь.
        Оранжевый 🟠 - нажата кнопка, но она еще не отпущена.
        Белый ⚪️ - все ок.
        """,
        """
        Раздел заявки, ну тут все просто - здесь находятся все, кто хочет добавиться в контакты
        """,
        """
        Раздел настройки - в нем можно управлять настройками приложения, такими как: время для отмены вызова (не более 30 секунд), включать использование биометрии для отмены вызова (по-умолчанию выключена), а также отредактировать аккаунт (удалить, кстати, аккаунт можно там же)
        """,
        """
        Ну вот и все!
        Основное я тебе рассказал, думаю, дальше разберешься 😉
        Всего наилучшего !
        Если вдруг понадоблюсь, меня можно вызвать из раздела настроек 🙂
        """]
        
        if UserDefaults.standard.bool(forKey: "presentationWasViewed") {
            screenContent.removeFirst(2)
        }
        
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
        
        return contentViewController
    }
    
    //MARK: Визуальное оформление
    //MARK: Стиль статус бара
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
