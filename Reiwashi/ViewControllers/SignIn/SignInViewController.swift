//
//  SignInViewController.swift
//  Reiwashi
//
//  Created by 張翔 on 2020/02/19.
//  Copyright © 2020 2222_d. All rights reserved.
//

import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var sexTextField: UITextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
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
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    lazy var birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.rx.date
            .map { date in
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                formatter.timeStyle = .none
                formatter.locale = Locale(identifier: "ja_JP")
                return formatter.string(from: date)
        }.bind(to: birthdayTextField.rx.text)
            .disposed(by: disposeBag)
        return datePicker
    }()
    
    lazy var birthdayDatePickerViewToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 45))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(birthdayDatePickerViewDone))
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
        toolbar.setItems([spaceItem, doneButtonItem], animated: true)
        return toolbar
    }()
    
    let viewModel: ViewModel
    
    let disposeBag = DisposeBag()
    
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
        
        sexTextField.inputView = sexPickerView
        sexTextField.inputAccessoryView = sexPickerViewToolbar
        birthdayTextField.inputView = birthdayDatePicker
        birthdayTextField.inputAccessoryView = birthdayDatePickerViewToolbar
        placeTextField.inputView = placePickerView
        placeTextField.inputAccessoryView = placePickerViewToolbar
        
        bind()
    }
    
    func bind() {
        // ViewController -> ViewModel
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        birthdayDatePicker.rx.date
            .bind(to: viewModel.birthday)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: viewModel.signInButtonTapped)
            .disposed(by: disposeBag)
        
        // ViewModel -> ViewController
        viewModel.showErrorAlert
            .drive(onNext: { [weak self] in
                let alert = UIAlertController.simpleAlert(title: "エラー", message: "新規登録できませんでした")
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel.dismissViewController
            .drive(onNext: {
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.switchViewControllers()
            }).disposed(by: disposeBag)
        
        viewModel.isButtonEnabled
            .drive(signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.showHud
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    @objc func sexPickerViewDone() {
        sexTextField.resignFirstResponder()
    }
    
    @objc func birthdayDatePickerViewDone() {
        birthdayTextField.resignFirstResponder()
    }
    
    @objc func placePickerViewDone() {
        placeTextField.resignFirstResponder()
    }
}

extension SignInViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sexPickerView:
            return Sex.allCases.count + 1
        case placePickerView:
            return Place.allCases.count + 1
        default:
            return 0
        }
    }
}

extension SignInViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "選択してください"
        }
        switch pickerView {
        case sexPickerView:
            return Sex.allCases[row - 1].name
        case placePickerView:
            return Place.allCases[row - 1].name
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sexPickerView:
            if row <= 0 {
                sexTextField.text = ""
                viewModel.sex.accept(nil)
            } else {
                sexTextField.text = Sex.allCases[row - 1].name
                viewModel.sex.accept(Sex.allCases[row - 1])
            }
        case placePickerView:
            if row <= 0 {
                placeTextField.text = ""
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
