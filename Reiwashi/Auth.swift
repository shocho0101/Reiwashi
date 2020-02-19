//
//  Auth.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import KeychainAccess

enum Auth {
    private static let keychain = Keychain(service: "jp.2222_d.reiwashi")
    private static let tokenKey = "api_token"
    
    static var token: String? {
        get {
            return keychain[tokenKey]
        }
        set {
            keychain[tokenKey] = newValue
        }
    }
    
    static var isLoggedIn: Bool {
        return token != nil
    }
}
