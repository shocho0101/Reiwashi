//
//  DeleteFabDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum DeleteFabDataGatewayAction: DataGatewayAction {
    
    struct Input {
        var wordId: Int
    }
    
    private struct Response: Codable {
        let status: Status
        
        enum Status: String, Codable {
            case success
            case error
        }
    }
    
    static func api() -> Action<Input, Void> {
        return .init { input -> Observable<Void> in
            return APIClient.request(.delete, path: "fabs/" + String(input.wordId), needAuth: true, responseType: Response.self)
                .map { response in
                    switch response.status {
                    case .success:
                        return ()
                    case .error:
                        throw ReiwashiError.dataGatewayError
                    }
            }
        }
    }
}
