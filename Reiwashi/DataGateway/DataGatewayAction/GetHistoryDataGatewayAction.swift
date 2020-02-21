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
        return .init { input -> Observable<[Word]> in
            return APIClient.request(.get, path: "words/api?period=" + input.period.rawValue + "&page=" + input.page.description, needAuth: false, responseType: History.self)
                .map{ history in
                    //fabCountを含んだwordを返す
                    history.word.map { word in
                        return Word(id: word.id,
                                    fabCount: history.fabs[String(word.id)]!,
                                    name: word.name,
                                    userId: word.userId,
                                    tagId: word.tagId,
                                    sex: word.sex,
                                    birthday: word.birthday,
                                    place: word.place,
                                    isFab: false,
                                    createdAt: word.createdAt,
                                    updatedAt: word.updatedAt)
                    }
                    
                    
            }
        }
//        return .init { input -> Observable<History> in
//            return Observable.just([Word(id: 1, fabCount: 10, name: "新型コロナ", userId: 1, tagId: nil, sex: .M, birthday: "2020-02-17", place: .tokyo),Word(id: 2,  fabCount: 20, name: "篭池理事長", userId: 1, tagId: nil, sex: .M, birthday: "2020-02-18", place: .tokyo)])
//        }
    }
}
