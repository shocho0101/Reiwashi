//
//  WelcomeViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WelcomeViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.rx.tap.asDriver().drive(onNext: { [navigationController] _ in
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }).disposed(by: disposeBag)
        
        signInButton.rx.tap.asDriver().drive(onNext: { [navigationController] _ in
            navigationController?.pushViewController(SignInViewController(), animated: true)
        }).disposed(by: disposeBag)
    }
    
}
