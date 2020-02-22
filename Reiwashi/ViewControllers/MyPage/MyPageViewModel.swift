//
//  MyPageViewModel.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/21.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa

extension MyPageViewController {
    class ViewModel {
        
        let getUserInfoAction = DataGateway.getAction(GetUserInfoDataGatewayAction.self)
        let logoutAction = DataGateway.getAction(LogoutDataGatewayAction.self)
        
        init() {
            
        }
        
        func firstRequest() {
            getUserInfoAction.execute()
        }
        
        var name: Driver<String> {
            return getUserInfoAction.elements
                .debug()
                .map { $0.name }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var email: Driver<String> {
            return getUserInfoAction.elements
                .map { $0.email }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        // TODO: jsonのフォーマットできたらちゃんとjsonをはパースする
        var birthday: Driver<String> {
            return getUserInfoAction.elements
                .map { $0.birthday }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var sex: Driver<Sex> {
            return getUserInfoAction.elements
                .map { $0.sex }
                .asDriver(onErrorDriveWith: .empty())
        }
        
        var place: Driver<Place> {
            return getUserInfoAction.elements
                .map { $0.place }
                .asDriver(onErrorDriveWith: .empty())
        }
    }
}
