//
//  SignUpDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

enum SignUpDataGatewayAction: DataGatewayAction {
    
    struct Input: Codable {
        let name: String
        let email: String
        let sex: Sex
        let birthday: Date
        let place: Place
        let password: String
    }
    
    private struct Response: Codable {
        let status: Status
        let userId: Int?
        let token: String?
        
        enum Status: String, Codable {
            case success
            case error
        }
    }
    
    static func api() -> Action<Input, Void> {
        return .init { input -> Observable<Void> in
            return APIClient.request(.post, path: "users", body: input, needAuth: false, responseType: Response.self)
                .do(onNext: { response in
                    guard response.status == .success,
                        let token = response.token else {
                            throw ReiwashiError.dataGatewayError
                    }
                    Auth.token = token
                }).map { _ in () }
        }
    }
}


