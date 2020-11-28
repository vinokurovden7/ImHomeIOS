//
//  RequestVM.swift
//  ImHome
//
//  Created by Денис Винокуров on 25.11.2020.
//  Copyright © 2020 Денис Винокуров. All rights reserved.
//

import Foundation
import RealmSwift
class RequestVM: RequestViewModelType {
    
    private let storageManager = StorageManager()
    private var requests: Results<Request>!
    private var typeRequest = 0
    
    func numberOfRows() -> Int {
        requests = storageManager.getRequests()?.filter("typeRequest CONTAINS[c] %@", typeRequest)
        return requests.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> RequestCellSubclassDelegate? {
        var request = Request()
        request = requests[indexPath.row]
        return RequestCellVM(request: request)
    }
    
    func changeTypeRequest(typeRequest: Int) {
        self.typeRequest = typeRequest
    }
    
    init(typeRequest: Int) {
        self.typeRequest = typeRequest
    }
}
