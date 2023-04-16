//
//  SignUpViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class SignUpViewController: BaseViewController, BaseViewControllerProtocol {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var blindPassword: UIButton!
    @IBOutlet weak var rePassWordText: UITextField!
    @IBOutlet weak var blindRepassWord: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var viewModel: SignUpViewModel!

    var present: Bool = true
    required init?(coder: NSCoder, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
    }

    func setupViews() {
        registerButton.isEnabled = false
        registerButton.alpha = 0.5
    }

    func setupRx() {
        let obser = Observable.combineLatest(passWordText.rx.text.orEmpty.asObservable(),
                                             rePassWordText.rx.text.orEmpty.asObservable())

        obser.skip(1).subscribe(onNext: {[weak self] pass, repass in
            guard let self = self else { return }
            self.registerButton.isEnabled = (pass == repass && !pass.isEmpty)
            self.registerButton.alpha = (self.registerButton.isEnabled ? 1.0 : 0.5)
        }).disposed(by: disposeBag)

        blindPassword.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.passWordText.isSecureTextEntry.toggle()
            self.blindPassword.setImage(self.passWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)
        }).disposed(by: disposeBag)

        blindRepassWord.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.rePassWordText.isSecureTextEntry.toggle()
            self.blindRepassWord.setImage(self.passWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)
        }).disposed(by: disposeBag)

        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if self.present {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
        
        registerButton.rx.tap.subscribe(onNext: { [weak self] _ in
            //TODO: register
        }).disposed(by: disposeBag)
    }

    func bindingViewModels() {

    }

}
