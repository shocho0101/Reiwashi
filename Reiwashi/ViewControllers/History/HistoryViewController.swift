//
//  HistoryViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/16.
//  Copyright © 2020 2222_d. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet var addBarButtonItem: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "令和史"
        setUp()
        bind()
    }
    
    func setUp() {
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:nil)
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
    }
    
    func bind() {
        addBarButtonItem.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.pushViewController(AddHistoryViewController(), animated: true)
        })
        .disposed(by: disposeBag)
    }
}
