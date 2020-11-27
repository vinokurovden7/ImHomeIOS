//
//  NewContactCellDelegate.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol NewContactCellDelegate: class {
    var fullnameContact: String {get}
    var emailContact: String {get}
    var photoContact: UIImage {get}
}
