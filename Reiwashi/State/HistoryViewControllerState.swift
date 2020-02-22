//
//  HistoryViewControllerState.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/22.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

class HistoryViewControllerState {
    var period: Period
    var age:Age?
    var place: Place?
    var sex: Sex?
    var page: Int
    
    init(period:Period, age: Age?, place: Place?, sex: Sex?, page: Int) {
        self.period = period
        self.age = age
        self.place = place
        self.sex = sex
        self.page = page
    }
    
    func setState(age:Age?, place:Place?, sex:Sex?) {
        self.age = age
        self.place = place
        self.sex = sex
    }
}
