//
//  LoginViewModel.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension LoginViewController {
    class ViewModel {
        let email = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
        let loginButtonTapped = PublishRelay<Void>()
        
        private lazy var loginInfo = BehaviorRelay.combineLatest(email, password)
        
        private let action = DataGateway.getAction(LoginDataGatewayAction.self)
        
        private let disposeBag = DisposeBag()
        
        init() {
            loginButtonTapped
                .withLatestFrom(action.executing)
                .filter { !$0 }
                .withLatestFrom(loginInfo)
                .filter { !$0.isEmpty && !$1.isEmpty }
                .map { LoginDataGatewayAction.Input(email: $0, password: $1) }
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
                loginInfo.map { $0.isEmpty || $1.isEmpty },
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
