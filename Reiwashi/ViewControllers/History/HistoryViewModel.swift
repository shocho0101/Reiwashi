//
//  HistoryViewModel.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

extension HistoryViewController {
    class ViewModel {
        
        let action = DataGateway.getAction(GetHistoryDataGatewayAction.self)
        private let disposeBag = DisposeBag()
        //        let state: HistoryViewControllerState
        
        let state: BehaviorRelay<HistoryViewControllerState>
        
        
        init() {
            let initialState = HistoryViewControllerState(period: .month, age: nil, place: nil, sex: nil, page: 1)
            self.state = BehaviorRelay<HistoryViewControllerState>(value: initialState)
            
            action.elements
                        .subscribe(onNext: {value in
                        print(value)
                        }).disposed(by: disposeBag)
            
//            state
//                .map { GetHistoryDataGatewayAction.Input(period: $0.period, age: $0.age, sex: $0.sex, place: $0.place, page: $0.page)}
//                .bind(to: action.inputs)
//                .disposed(by: disposeBag)
            
        
        }
        
        func initRequest() {
            action.execute(GetHistoryDataGatewayAction.Input(period: state.value.period,
                                                             age: state.value.age,
                                                             sex: state.value.sex,
                                                             place: state.value.place,
                                                             page: state.value.page))
            
            state
                      .map {
                        GetHistoryDataGatewayAction.Input(period: $0.period, age: $0.age, sex: $0.sex, place: $0.place, page: $0.page)
                        
            }
                      .bind(to: action.inputs)
                      .disposed(by: disposeBag)
        }
        
        
        var showErrorAlert: Driver<Void> {
            return action.errors
                .map { _ in ()
                    
            }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        
        
        
        
    }
}
