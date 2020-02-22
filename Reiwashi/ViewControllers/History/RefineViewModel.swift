//
//  RefineViewModel.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/22.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa

extension RefineViewController {
    class ViewModel {
        let period = BehaviorRelay<Period>(value: .month)
        let age = BehaviorRelay<Age?>(value: nil)
        let sex = BehaviorRelay<Sex?>(value: nil)
        let place = BehaviorRelay<Place?>(value: nil)
        let refineButtonTapped = PublishRelay<Void>()
        private lazy var refineInfo = BehaviorRelay.combineLatest(period, age, place, sex)
        
        private let disposeBag = DisposeBag()
        
        init(historyViewController: HistoryViewController) {
            refineButtonTapped
                .withLatestFrom(refineInfo)
                .map {
                    HistoryViewControllerState(period: $0.0, age: $0.1, place: $0.2, sex: $0.3, page: 1)
                    
            }
                .bind(to: historyViewController.viewModel.state)
                .disposed(by: disposeBag)
        }
        
    }
}

