//
//  AddHistoryViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddHistoryViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    let viewModel: ViewModel
    
    let disposeBag = DisposeBag()
    
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
    
    func bind() {
        textField.rx.text
            .orEmpty
            .bind(to: viewModel.word)
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .bind(to: viewModel.addButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.isButtonEnabled
            .drive(addButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

}
