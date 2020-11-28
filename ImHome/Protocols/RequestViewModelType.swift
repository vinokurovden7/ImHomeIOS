//
//  RequestViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 25.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
protocol RequestViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> RequestCellSubclassDelegate?
    func changeTypeRequest(typeRequest: Int)
}
