//
//  MyPageViewModel.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/21.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation

extension MyPageViewController {
    class ViewModel {
        let logoutAction = DataGateway.getAction(LogoutDataGatewayAction.self)
    }
}
