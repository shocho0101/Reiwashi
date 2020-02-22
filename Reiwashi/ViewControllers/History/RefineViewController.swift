//
//  RefineViewController.swift
//  Reiwashi
//
//  Created by 中嶋裕也 on 2020/02/22.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit

class RefineViewController: UIViewController {
    
    @IBOutlet var periodTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var sexTextField: UITextField!
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var refineButton: UIButton!
    
    let viewModel: ViewModel
    private let disposeBag = DisposeBag()
    private var historyViewController: HistoryViewController!
    
    lazy var periodPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var periodPickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(periodPickerViewDone))
        doneButtonItem.tintColor = #colorLiteral(red: 0.4860000014, green: 0.2939999998, blue: 0.5529999733, alpha: 1)
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    lazy var agePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var agePickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(agePickerViewDone))
        doneButtonItem.tintColor = #colorLiteral(red: 0.4860000014, green: 0.2939999998, blue: 0.5529999733, alpha: 1)
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    lazy var sexPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var sexPickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(sexPickerViewDone))
        doneButtonItem.tintColor = #colorLiteral(red: 0.4860000014, green: 0.2939999998, blue: 0.5529999733, alpha: 1)
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    
    
    lazy var placePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var placePickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(placePickerViewDone))
        doneButtonItem.tintColor = #colorLiteral(red: 0.4860000014, green: 0.2939999998, blue: 0.5529999733, alpha: 1)
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    init(viewController: HistoryViewController) {
        historyViewController = viewController
        self.viewModel = ViewModel(historyViewController: historyViewController)
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        periodTextField.inputView = periodPickerView
        periodTextField.inputAccessoryView = periodPickerViewToolbar
        sexTextField.inputView = sexPickerView
        sexTextField.inputAccessoryView = sexPickerViewToolbar
        ageTextField.inputView = agePickerView
        ageTextField.inputAccessoryView = agePickerViewToolbar
        placeTextField.inputView = placePickerView
        placeTextField.inputAccessoryView = placePickerViewToolbar
        bind()
        setUp()
    }
    
    @objc func periodPickerViewDone() {
        periodTextField.resignFirstResponder()
    }
    
    @objc func agePickerViewDone() {
        ageTextField.resignFirstResponder()
    }
    
    @objc func sexPickerViewDone() {
        sexTextField.resignFirstResponder()
    }
    
    @objc func placePickerViewDone() {
        placeTextField.resignFirstResponder()
    }
    
    func bind() {
        refineButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        refineButton.rx.tap
            .bind(to: viewModel.refineButtonTapped)
            .disposed(by: disposeBag)
    }
    
    func setUp() {
        let state = historyViewController.viewModel.state
        periodTextField.text = state.value.period.name
        ageTextField.text = state.value.age?.name ?? "選択なし"
        sexTextField.text = state.value.sex?.name ?? "選択なし"
        placeTextField.text = state.value.place?.name ?? "選択なし"
        
    }
}


extension RefineViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case periodPickerView:
            return Period.allCases.count
        case agePickerView:
            return Age.allCases.count + 1
        case sexPickerView:
            return Sex.allCases.count + 1
        case placePickerView:
            return Place.allCases.count + 1
        default:
            return 0
        }
    }
}

extension RefineViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case periodPickerView:
            return Period.allCases[row].name
        case agePickerView:
            if row == 0 {
                return "指定なし"
            }
            return Age.allCases[row - 1].name
        case sexPickerView:
            if row == 0 {
                return "指定なし"
            }
            return Sex.allCases[row - 1].name
        case placePickerView:
            if row == 0 {
                return "指定なし"
            }
            return Place.allCases[row - 1].name
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case periodPickerView:
            periodTextField.text = Period.allCases[row].name
            viewModel.period.accept(Period.allCases[row])
        case agePickerView:
            if row <= 0 {
                ageTextField.text = "指定なし"
                viewModel.age.accept(nil)
            } else {
                ageTextField.text = Age.allCases[row - 1].name
                viewModel.age.accept(Age.allCases[row - 1])
            }
        case sexPickerView:
            if row <= 0 {
                sexTextField.text = "指定なし"
                viewModel.sex.accept(nil)
            } else {
                sexTextField.text = Sex.allCases[row - 1].name
                viewModel.sex.accept(Sex.allCases[row - 1])
            }
        case placePickerView:
            if row <= 0 {
                placeTextField.text = "指定なし"
                viewModel.place.accept(nil)
            } else {
                placeTextField.text = Place.allCases[row - 1].name
                viewModel.place.accept(Place.allCases[row - 1])
            }
        default:
            break
        }
        
    }
}
