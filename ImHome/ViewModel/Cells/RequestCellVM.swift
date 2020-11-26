//
//  RequestCellVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 25.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
class RequestCellVM: RequestCellSubclassDelegate {
    
    private var request: Request
    var messageTextLabel: String { return request.messageRequest }
    
    var nameContactLabel: String { return "\(request.secondNameContactRequest) \(request.firstNameContactRequest) \(request.thirdNameContactRequest ?? "")" }
    
    var emailContactLabel: String { return request.emailContactRequest }
    
    var imageRequest: UIImage { return UIImage(data: request.photoContactRequest!) ?? UIImage() }
    
    init(request: Request) {
        self.request = request
    }
}
