//
//  GetHistoryDataGatewayAction.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/20.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Action
import RxSwift

enum GetHistoryDataGatewayAction: DataGatewayAction {
    
    struct Input {
        let period: Period
        let page: Int
        enum Period: String {
            case month
            case year
        }
    }
    
    
    static func api() -> Action<Input, [Word]> {
        return Action<Input, [Word]>.init { input -> Observable<[Word]> in
            return Observable.create { observer -> Disposable in
                APIClient.request(.get, path: "words/api?period=" + input.period.rawValue + "&page=" + input.page.description, needAuth: false, responseType: History.self)
                    .subscribe(onNext: { history in
                        APIClient.request(.get, path: "fabs/mypage", needAuth: true, responseType: [Fab].self)
                            .subscribe(onNext: { fabs in
                                let words = history.word.map { word in
                                    return Word(id: word.id,
                                                fabCount: history.fabs[String(word.id)]!,
                                                name: word.name,
                                                userId: word.userId,
                                                tagId: word.tagId,
                                                isFab: fabs.firstIndex { $0.wordId == word.id } != nil,
                                                createdAt: word.createdAt,
                                                updatedAt: word.updatedAt)
                                }
                                
                                observer.onNext(words)
                                observer.onCompleted()
                            })
                        
                    })
            }
        }
    }
}
