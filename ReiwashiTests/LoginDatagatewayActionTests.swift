//
//  LoginDatagatewayAction.swift
//  ReiwashiTests
//
//  Created by 張翔 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import XCTest
import RxSwift
@testable import Reiwashi

class LoginDataGatewayActionTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testApi() {
        let exp = expectation(description: "api")
        
        let action = LoginDataGatewayAction.api()
        
        let input = LoginDataGatewayAction.Input(email: "sgs@gmail.com", password: "reiwa")
        
        action.execute(input)
            .subscribe(onNext: {
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
}
