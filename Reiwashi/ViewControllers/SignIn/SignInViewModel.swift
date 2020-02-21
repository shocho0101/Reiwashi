//
//  SignInViewModel.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa

extension SignInViewController {
    class ViewModel {
        let name = BehaviorRelay<String>(value: "")
        let email = BehaviorRelay<String>(value: "")
        let sex = BehaviorRelay<Sex?>(value: nil)
        let birthday = BehaviorRelay<Date>(value: Date())
        let place = BehaviorRelay<Place?>(value: nil)
        let password = BehaviorRelay<String>(value: "")
        let signInButtonTapped = PublishRelay<Void>()
        
        private let action = DataGateway.getAction(SignUpDataGatewayAction.self)
        
        private lazy var signInInfo = BehaviorRelay.combineLatest(name, email, sex, birthday, place, password).share()
        
        private let disposeBag = DisposeBag()
        
        init() {
            signInButtonTapped
                .withLatestFrom(action.executing)
                .filter { !$0 }
                .withLatestFrom(signInInfo)
                .filter { !$0.isEmpty && !$1.isEmpty && $2 != nil && $4 != nil && !$5.isEmpty }
                .map { SignUpDataGatewayAction.Input(name: $0, email: $1, sex: $2!, birthday: $3, place: $4!, password: $5) }
                .bind(to: action.inputs)
                .disposed(by: disposeBag)
        }
        
        var showErrorAlert: Driver<Void> {
            return action.errors
                .map { _ in () }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var dismissViewController: Driver<Void> {
            return action.elements
                .map { _ in () }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var isButtonEnabled: Driver<Bool> {
            return Observable.combineLatest(
                signInInfo.map { $0.isEmpty || $1.isEmpty || $2 == nil || $4 == nil && $5.isEmpty },
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

