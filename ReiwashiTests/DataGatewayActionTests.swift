//
//  AddWordDataGatewayActionTests.swift
//  ReiwashiTests
//
//  Created by 張翔 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import XCTest
import RxSwift
@testable import Reiwashi

class DataGatewayActionTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testAddWord() {
        let exp = expectation(description: "api")
        
        let input = AddWordDataGatewayAction.Input(name: "test")
        let action = AddWordDataGatewayAction.api()
        
        action.execute(input)
            .subscribe(onNext: { _ in
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
}
