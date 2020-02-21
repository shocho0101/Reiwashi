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
    
    @IBOutlet var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel: ViewModel
    init() {
        self.viewModel = ViewModel()
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        viewModel.initRequest()
//        viewModel.action.execute(GetHistoryDataGatewayAction.Input(period: .month, page: 1))
    }
    
    func setUp() {
        title = "令和史"
        tableView.register(UINib(nibName: "NormalTableViewCell", bundle: nil), forCellReuseIdentifier: "NormalTableViewCell")
        tableView.rowHeight = 50.0
    }
    
    func bind() {
        viewModel.action.elements.bind(to: tableView.rx.items(cellIdentifier: "NormalTableViewCell", cellType: NormalTableViewCell.self)) { row, element, cell in
                cell.nameLabel.text = element.name
        }
        .disposed(by: disposeBag)
    }
}

