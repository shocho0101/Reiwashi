//
//  GetFabListDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum GetFabListDataGatewayAction: DataGatewayAction {
    static func api() -> Action<Void, [Fab]> {
        return .init { _ -> Observable<Output> in
            return APIClient.request(.get, path: "fabs/mypage", needAuth: true, responseType: [Fab].self)
        }
    }
}
