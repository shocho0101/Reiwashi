//
//  Errors.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

enum ReiwashiError: Error {
    case notLoggedIn
    case invalidPath
    case encodeError
    case dataGatewayError
    case already
}
