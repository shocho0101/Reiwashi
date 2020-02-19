//
//  DeleteUserDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum DeleteUserInfoDataGatewayAction: DataGatewayAction {
    
    private struct Response: Codable {
        let status: Status
        
        enum Status: String, Codable {
            case success
            case error
        }
    }
    
    // user_idを付与しないといけないので今の所使えない。サーバーの仕様を確認する必要あり。
    static func api() -> Action<Void, Void> {
        return .init { _ -> Observable<Void> in
            return APIClient.request(.delete, path: "users", needAuth: true, responseType: Response.self)
                .map { response in
                    switch response.status {
                    case .success:
                        return ()
                    case .error:
                        throw ReiwashiError.dataGatewayError
                    }
            }.do(onNext: {
                Auth.token = nil
            })
        }
    }
}

