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
import RxAlamofire
import Alamofire

enum AddWordDataGatewayAction: DataGatewayAction {
    static func api() -> Action<String, Void> {
        return .init { word -> Observable<Void> in
            return RxAlamofire.request(
                .post,
                "https://neo-tokyo.work:10282/words",
                parameters: ["name": word, "user_id": "1", "tag_id": "1"],
                encoding: JSONEncoding.default,
                headers: ["Content-Type":"application/json", "Authorization": "Token AVuaN6VRD9nnEaHPLJQ8LA7A"]
            )
            .map{ _ in () }
        }
    }
    
    static func mock() -> Action<String, Void> {
        return .init { word -> Observable<Void> in
            return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
        }
    }
}
