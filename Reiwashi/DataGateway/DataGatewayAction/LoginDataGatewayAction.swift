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
import Alamofire

struct LoginDataGatewayAction: DataGatewayAction {
    
    struct Input {
        let email: String
        let password: String
        
        var dictionary: [String: String] {
            return [
                "email": email,
                "password": password
            ]
        }
    }
    
    func api() -> Action<Input, Void> {
        return .init { input -> Observable<Void> in
            return RxAlamofire.request(
                .post,
                "https://neo-tokyo.work:10282/users/sign_in",
                parameters: input.dictionary,
                encoding: JSONEncoding.default,
                headers: ["Content-Type": "application/json"]
            ).map { _ in () }
        }
    }
    
    func mock() -> Action<Input, Void> {
        return .init { word -> Observable<Void> in
            return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
        }
    }
}
