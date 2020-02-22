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
    
    func setUpTabBar(){
        tabBar.tintColor = UIColor(red: 124/255, green: 75/255, blue: 141/255, alpha: 1.0)
        let maxNum = viewControllers?.count ?? 0
        for i in 0..<maxNum {
            let tabBarItem = tabBar.items?[i]
            switch i {
            case 0:
                tabBarItem?.title = "令和史"
                tabBarItem?.image = UIImage(systemName: "map")
            case 1:
                tabBarItem?.title = "追加"
                tabBarItem?.image = UIImage(systemName: "plus.square")
            case 2:
                tabBarItem?.title = "マイページ"
                tabBarItem?.image = UIImage(systemName: "person.crop.square")
            default:
                break
            }
        }
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
