//
//  ContactsViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 23.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol ContactsViewModelType {
    func getNumberOfSections() -> Int
    func getNumbersItemsInSection() -> Int
    func getMinimumLineSpacing() -> CGFloat
    func getEdgeInsets() -> UIEdgeInsets
    func getSizeItem() -> CGSize
    func getWidthPlits() -> CGFloat
}
