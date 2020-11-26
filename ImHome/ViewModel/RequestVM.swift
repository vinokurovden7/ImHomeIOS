//
//  RequestVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 25.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import UIKit
import RealmSwift
class RequestVM: RequestViewModelType {
    
    private let storageManager = StorageManager()
    private var requests: Results<Request>!
    
    func numberOfRows() -> Int {
        requests = storageManager.getRequests()
        return requests.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> RequestCellSubclassDelegate? {
        var request = Request()
        request = requests[indexPath.row]
        return RequestCellVM(request: request)
    }
}
