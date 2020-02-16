//
//  SVProgressHUD+Extensions.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: SVProgressHUD {
    public static var isAnimating: Binder<Bool> {
        return Binder(UIApplication.shared) { progressHUD, isVisible in
            if isVisible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}


