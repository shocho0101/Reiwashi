//
//  User.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var sex: Sex
    var birthday: String
    var place: Place
}


enum Sex: String, CaseIterable, Codable {
    case M
    case W
    
    var name: String {
        switch self {
        case .M: return "男性"
        case .W: return "女性"
        }
    }
}

enum Place: String, CaseIterable, Codable {
    case hokkaido
    case aomori
    case iwate
    case miyagi
    case akita
    case yamagata
    case fukushima
    case ibaraki
    case tochigi
    case gunma
    case saitama
    case chiba
    case tokyo
    case kanagawa
    case niigata
    case toyama
    case ishikawa
    case fukui
    case yamanashi
    case nagano
    case gifu
    case shizuoka
    case aichi
    case mie
    case shiga
    case kyoto
    case osaka
    case hyogo
    case nara
    case wakayama
    case tottori
    case shimane
    case okayama
    case hiroshima
    case yamaguchi
    case tokushima
    case kagawa
    case ehime
    case kochi
    case fukuoka
    case saga
    case nagasaki
    case kumamoto
    case oita
    case miyazaki
    case kagoshima
    case okinawa
   
    var name: String {
        switch self {
        case .hokkaido: return "北海道"
        case .aomori   : return "青森県"
        case .iwate    : return "岩手県"
        case .miyagi   : return "宮城県"
        case .akita    : return "秋田県"
        case .yamagata : return "山形県"
        case .fukushima: return "福島県"
        case .ibaraki : return "茨城県"
        case .tochigi : return "栃木県"
        case .gunma   : return "群馬県"
        case .saitama : return "埼玉県"
        case .chiba   : return "千葉県"
        case .tokyo   : return "東京都"
        case .kanagawa: return "神奈川県"
        case .niigata  : return "新潟県"
        case .toyama   : return "富山県"
        case .ishikawa : return "石川県"
        case .fukui    : return "福井県"
        case .yamanashi: return "山梨県"
        case .nagano   : return "長野県"
        case .gifu     : return "岐阜県"
        case .shizuoka : return "静岡県"
        case .aichi    : return "愛知県"
        case .mie     : return "三重県"
        case .shiga   : return "滋賀県"
        case .kyoto   : return "京都府"
        case .osaka   : return "大阪府"
        case .hyogo   : return "兵庫県"
        case .nara    : return "奈良県"
        case .wakayama: return "和歌山県"
        case .tottori  : return "鳥取県"
        case .shimane  : return "島根県"
        case .okayama  : return "岡山県"
        case .hiroshima: return "広島県"
        case .yamaguchi: return "山口県"
        case .tokushima: return "徳島県"
        case .kagawa   : return "香川県"
        case .ehime    : return "愛媛県"
        case .kochi    : return "高知県"
        case .fukuoka  : return "福岡県"
        case .saga     : return "佐賀県"
        case .nagasaki : return "長崎県"
        case .kumamoto : return "熊本県"
        case .oita     : return "大分県"
        case .miyazaki : return "宮崎県"
        case .kagoshima: return "鹿児県"
        case .okinawa  : return "沖縄県"
        }
    }
}


