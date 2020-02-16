//
//  AddWordDataGatewayRequest.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

struct AddWordDataGatewayRequest: DataGatewayAction {
    
    // TODO: implement this after api is ready
    func api() -> Action<String, Void> {
        fatalError("not implemented")
    }
    
    func mock() -> Action<String, Void> {
        return .init { word -> Observable<Void> in
            return Observable.just(())
        }
    }
}
