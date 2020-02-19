//
//  DataGatewayAction.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol DataGatewayAction {
    associatedtype Input
    associatedtype Output
    
    static func api() -> Action<Input, Output>
}
