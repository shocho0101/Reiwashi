//
//  LogoutDatagatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

import Action
import RxSwift

enum LogoutDataGatewayAction: DataGatewayAction {
    static func api() -> Action<Void, Void> {
        return .init { _ -> Observable<Void> in
            return Observable<Void>.just(()).do(onNext: { _ in
                Auth.token = nil
            })
        }
    }
}


