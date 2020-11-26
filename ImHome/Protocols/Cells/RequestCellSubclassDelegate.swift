//
//  RequestCellSubclassDelegate.swift
//  ImHome
//
//  Created by Денис Винокуров on 24.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol RequestCellSubclassDelegate: class {
    var messageTextLabel: String {get}
    var nameContactLabel: String {get}
    var emailContactLabel: String {get}
    var imageRequest: UIImage {get}
}
