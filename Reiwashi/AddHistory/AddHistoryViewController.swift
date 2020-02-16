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
import SVProgressHUD

class AddHistoryViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
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
        title = "追加"
        
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
        
        viewModel.showErrorAlert.drive { [weak self] in
            let alert = UIAlertController.simpleAlert(title: "エラー", message: "登録できませんでした")
            self?.present(alert, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
        
        viewModel.popViewController.drive { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        viewModel.showHud
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
