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
    
    // user_idを付与しないといけないので今の所使えない。サーバーの仕様を確認する必要あり。
    static func api() -> Action<Void, Output> {
        return .init { _ -> Observable<Output> in
            return APIClient.request(.get, path: "users", needAuth: true, responseType: Output.self)
        }
    }
}
