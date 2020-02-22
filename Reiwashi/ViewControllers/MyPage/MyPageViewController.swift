//
//  MyPageViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/21.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyPageViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var sexLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    
    @IBOutlet var logoutButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel: ViewModel
    
    init() {
        viewModel = ViewModel()
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "マイページ"
        
        bind()
        viewModel.firstRequest()
    }
    
    func bind() {
        // ViewController → ViewModel
        logoutButton.rx.tap
            .bind(to: viewModel.logoutAction.inputs)
            .disposed(by: disposeBag)
        
        viewModel.logoutAction
            .elements
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.switchWelcome()
            })
            .disposed(by: disposeBag)
        
        // ViewModel　→ ViewController
        viewModel.name
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.email
            .drive(emailLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.birthday
            .drive(birthdayLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.sex
            .map { $0.name }
            .drive(sexLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.place
            .map { $0.name }
            .drive(placeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.getUserInfoAction.execute()
    }
}


