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
        let didSelectCell = PublishRelay<Void>()
        let itemSelected = PublishRelay<IndexPath>()
        
        private let disposeBag = DisposeBag()
        
        init() {
        }
        
        func initRequest() {
            action.execute(GetHistoryDataGatewayAction.Input(period: .month, page: 1))
        }
        
        
        
        
    }
}
