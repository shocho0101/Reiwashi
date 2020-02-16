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

struct AddWordDataGatewayAction: DataGatewayAction {
    
    // TODO: APIができたら実装する
    func api() -> Action<String, Void> {
        fatalError("not implemented")
    }
    
    func mock() -> Action<String, Void> {
        return .init { word -> Observable<Void> in
            return Observable.just(()).delay(.seconds(1), scheduler: MainScheduler.instance)
        }
    }
}