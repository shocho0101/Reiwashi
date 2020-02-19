//
//  AddWordDataGatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

enum AddWordDataGatewayAction: DataGatewayAction {
    struct Input: Codable {
        let name: String
    }
    
    private struct Response: Codable {
        let status: Status
        
        enum Status: String, Codable {
            case success
            case already
            case error
        }
    }
    
    enum Output {
        case already
        case success
    }
    
    static func api() -> Action<Input, Output> {
        return Action.init { input -> Observable<Output> in
            return APIClient.request(.post, path: "words", body: input, needAuth: true, responseType: Response.self)
                .map { responce in
                    switch responce.status {
                    case .success:
                        return .success
                    case .already:
                        return .already
                    case .error:
                        throw ReiwashiError.dataGatewayError
                    }
                }
        }
    }
}
