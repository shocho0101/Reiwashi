//
//  LoginViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    private let viewModel: ViewModel
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.viewModel = ViewModel()
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        // ViewController -> ViewModel
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginButtonTapped)
            .disposed(by: disposeBag)
        
        // ViewModel -> ViewController
        viewModel.showErrorAlert
            .drive(onNext: { [weak self] in
                let alert = UIAlertController.simpleAlert(title: "エラー", message: "ログインできませんでした")
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel.dismissViewController
            .drive(onNext: {
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.switchViewControllers()
            }).disposed(by: disposeBag)
        
        viewModel.isButtonEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.showHud
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}
