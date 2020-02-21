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
    }
    
    func bind() {
        
        logoutButton.rx.tap
            .bind(to: viewModel.logoutAction.inputs)
            .disposed(by: disposeBag)
    }
}


