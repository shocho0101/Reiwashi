//
//  ModalTabBarController.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/18.
//  Copyright © 2020 2222_d. All rights reserved.
//

import Foundation
import UIKit

class ModalTabBarController: UITabBarController {
    override func viewDidLoad() {
        delegate = self
    }
}

extension ModalTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddHistoryViewController {
            let addHistoryViewController = AddHistoryViewController()
            tabBarController.present(addHistoryViewController, animated: true, completion: nil)
            return false
        }
        return true
    }
}
