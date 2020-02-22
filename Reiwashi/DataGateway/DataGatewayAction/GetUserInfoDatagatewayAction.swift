//
//  GetUserInfoDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum GetUserInfoDataGatewayAction: DataGatewayAction {
    static func api() -> Action<Void, User> {
        return .init { _ -> Observable<User> in
            return APIClient.request(.get, path: "users/1", needAuth: true, responseType: User.self)
        }
    }
}
