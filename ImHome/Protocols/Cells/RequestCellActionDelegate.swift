//
//  RequestCellActionDelegate.swift
//  ImHome
//
//  Created by Денис Винокуров on 25.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
protocol RequestCellActionDelegate {
    func acceptButtonTapped(cell: RequestCell)
    func declineButtonTapped(cell: RequestCell)
    func checkCountRecord()
}
