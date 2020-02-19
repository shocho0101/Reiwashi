//
//  GetFabDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum GetFabDataGatewayAction: DataGatewayAction {
    
    struct Input {
        var wordId: Int
    }
    
    static func api() -> Action<Input, Fab?> {
        return .init { input -> Observable<Output> in
            return APIClient.request(.get, path: "fabs/" + String(input.wordId), needAuth: true, responseType: Fab?.self)
        }
    }
}

