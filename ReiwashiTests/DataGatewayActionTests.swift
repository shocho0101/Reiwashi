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
    
    func testAddFab() {
        let exp = expectation(description: "api")
        
        let input = AddFabDataGatewayAction.Input(wordId: 4)
        let action = AddFabDataGatewayAction.api()
        
        action.execute(input)
            .subscribe(onNext: { _ in
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testDeleteFab() {
        let exp = expectation(description: "api")
        
        let input = DeleteFabDataGatewayAction.Input(wordId: 4)
        let action = DeleteFabDataGatewayAction.api()
        
        action.execute(input)
            .subscribe(onNext: { _ in
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testGetFabList() {
        let exp = expectation(description: "api")
        
        let action = GetFabListDataGatewayAction.api()
        
        action.execute(())
            .subscribe(onNext: { _ in
                exp.fulfill()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
    
    func testGetFab() {
        let exp = expectation(description: "api")
        
        let action = GetFabDataGatewayAction.api()
        
        action.execute(.init(wordId: 4))
            .subscribe(onNext: { _ in
                exp.fulfill()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        wait(for: [exp], timeout: 5)
    }
    
    
}
