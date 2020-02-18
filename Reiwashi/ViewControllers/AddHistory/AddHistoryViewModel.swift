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
        
        private let action = DataGateway.getAction(AddWordDataGatewayAction.self)
        
        private let disposeBag = DisposeBag()
        
        init() {
            addButtonTapped
                .withLatestFrom(action.executing)
                .filter { !$0 }
                .withLatestFrom(word)
                .filter { !$0.isEmpty }
                .bind(to: action.inputs)
                .disposed(by: disposeBag)
        }
        
        var showErrorAlert: Driver<Void> {
            return action.errors
                .map { _ in () }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var popViewController: Driver<Void> {
            return action.elements
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var isButtonEnabled: Driver<Bool> {
            return Observable.combineLatest(
                    word.map { $0.isEmpty },
                    action.executing)
                .map { !$0 && !$1 }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var showHud: Driver<Bool> {
            return action.executing
                .asDriver(onErrorDriveWith: .empty())
        }
    }
}
