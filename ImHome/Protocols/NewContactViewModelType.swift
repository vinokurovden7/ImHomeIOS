//
//  NewContactViewModelType.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol NewContactViewModelType {
    func numberOfRowsInSection() -> Int
    func filteringContact(filteredString: String)
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewContactCellDelegate?
}
