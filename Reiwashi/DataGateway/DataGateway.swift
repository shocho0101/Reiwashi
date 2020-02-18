//
//  DataGateway.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action

enum DataGateway {
    
    static var workType: WorkType = .mock
    
    static func getAction<T: DataGatewayAction>(_ request: T.Type) -> Action<T.Input, T.Output> {
        switch workType {
        case .api:
            return request.api()
        case .mock:
            return request.mock()
        }
    }
    
    enum WorkType {
        case api
        case mock
    }
}


