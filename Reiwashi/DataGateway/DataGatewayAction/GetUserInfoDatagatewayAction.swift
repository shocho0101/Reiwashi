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
    
    struct Output: Codable {
        var name: String
        var email: String
        var sex: Sex
        var birthday: Date
        var place: Place
    }
    
    static func api() -> Action<Void, Output> {
        return .init { _ -> Observable<Output> in
            return APIClient.request(.post, path: "users", needAuth: false, responseType: Output.self)
        }
    }
}
