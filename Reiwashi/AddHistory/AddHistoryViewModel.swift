//
//  AddHistoryViewModel.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

extension AddHistoryViewController {
    class ViewModel {
        let word = BehaviorRelay<String>(value: "")
        let addButtonTapped = PublishRelay<Void>()
        
        let action = DataGateway.getAction(AddWordDataGatewayRequest())
        
        let disposeBag = DisposeBag()
        
        init() {
            addButtonTapped
                .withLatestFrom(word)
                .bind(to: action.inputs)
                .disposed(by: disposeBag)
        }
        
        var showErrorMassage: Driver<Void> {
            return action.errors
                .map { _ in () }
                .asDriver(onErrorJustReturn: ())
        }
        
        var success: Driver<Void> {
            return action.elements
                .asDriver(onErrorJustReturn: ())
        }
        
        var isButtonEnabled: Driver<Bool> {
            return word
                .map { $0.isEmpty }
                .asDriver(onErrorJustReturn: false)
        }
    }
}
