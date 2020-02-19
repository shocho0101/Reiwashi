//
//  AddFabDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum AddFabDataGatewayAction: DataGatewayAction {
    
    struct Input: Codable {
        var wordId: Int
    }
    
    private struct Response: Codable {
        let status: Status
        
        enum Status: String, Codable {
            case success
            case already
            case error
        }
    }
    
    static func api() -> Action<Input, Void> {
        return .init { input -> Observable<Void> in
            return APIClient.request(.post, path: "fabs", body: input, needAuth: true, responseType: Response.self)
                .map { response in
                    switch response.status {
                    case .success:
                        return ()
                    case .already:
                        throw ReiwashiError.already
                    case .error:
                        throw ReiwashiError.dataGatewayError
                    }
            }
        }
    }
}
