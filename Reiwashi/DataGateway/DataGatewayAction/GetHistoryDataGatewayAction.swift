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
        let age: Age?
        let sex: Sex?
        let place: Place?
        let page: Int
    }
    
    
    static func api() -> Action<Input, [Word]> {
        return Action<Input, [Word]>.init { input -> Observable<[Word]> in
            return Observable.create { observer -> Disposable in
                let periodPath = "?period=" + input.period.rawValue
                var agePath = ""
                if let age = input.age {
                    agePath = "&age=" + age.queryValue
                }
                var sexPath = ""
                if let sex = input.sex {
                    sexPath = "&sex=" + sex.rawValue
                }
                var placePath = ""
                if let place = input.place {
                    placePath = "&sex=" + place.rawValue
                }
                let pagePath = "&page=" + input.page.description
                print("words/api" + periodPath + agePath + sexPath + placePath + pagePath)
                return APIClient.request(.get, path: "words/api" + periodPath + sexPath + placePath + pagePath , needAuth: false, responseType: History.self)
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
