//
//  ContactsCellDelegate.swift
//  ImHome
//
//  Created by Денис Винокуров on 27.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
protocol ContactsCellDelegate: class {
    var nameContact: String {get}
    var emailContact: String {get}
    var imageContact: UIImage {get}
    var statusContact: Int {get}
}
