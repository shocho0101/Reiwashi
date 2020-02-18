//
//  LoginDataGatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa
import Action
import RxAlamofire
import KeychainAccess
import Alamofire

enum LoginDataGatewayAction: DataGatewayAction {
    
    struct Input: Encodable {
        let email: String
        let password: String
    }
    
    private struct Response: Codable {
        let status: String
        let token: String
    }
    
    static func api() -> Action<Input, Void> {
        return .init { input -> Observable<Void> in
            return APIClient.request(.post, path: "users/sign_in", body: input, needAuth: false, responseType: Response.self)
                .do(onNext: { response in
                    let keychain = Keychain(service: "jp.2222_d.reiwashi")
                    keychain["api_token"] = response.token
                }).map { _ in () }
        }
    }
    
    static func mock() -> Action<Input, Void> {
        return .init { word -> Observable<Void> in
            return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
        }
    }
}
