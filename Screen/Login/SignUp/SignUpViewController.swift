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
        bindingViewModels()
    }

    func setupViews() {
        registerButton.isEnabled = false
        registerButton.alpha = 0.5
    }

    func setupRx() {
        let obser = Observable.combineLatest(userNameText.rx.text.orEmpty.asObservable(),
                                             passWordText.rx.text.orEmpty.asObservable(),
                                             rePassWordText.rx.text.orEmpty.asObservable())

        obser.skip(1).subscribe(onNext: {[weak self] user, pass, repass in
            guard let self = self else { return }
            self.registerButton.isEnabled = (pass == repass
                                             && !pass.isEmpty
                                             && pass.isValidPassWord()
                                             && !user.isEmpty
                                             && user.isValidEmail())
            self.registerButton.alpha = (self.registerButton.isEnabled ? 1.0 : 0.5)
        }).disposed(by: disposeBag)

        userNameText.rx.text.orEmpty.subscribe(onNext: {[weak self] user in
            self?.userNameText.borderColor = user.isValidEmail() ? R.color.color283442() ?? .black : R.color.color852814() ?? .red
        }).disposed(by: disposeBag)

        passWordText.rx.text.orEmpty.subscribe(onNext: {[weak self] pass in
            self?.passWordText.borderColor = pass.isValidPassWord() ? R.color.color283442() ?? .black : R.color.color852814() ?? .red
        }).disposed(by: disposeBag)

        rePassWordText.rx.text.orEmpty.subscribe(onNext: {[weak self] pass in
            self?.rePassWordText.borderColor = pass.isValidPassWord() ? R.color.color283442() ?? .black : R.color.color852814() ?? .red
        }).disposed(by: disposeBag)

        blindPassword.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.passWordText.isSecureTextEntry.toggle()
            self.blindPassword.setImage(self.passWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)
        }).disposed(by: disposeBag)

        blindRepassWord.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.rePassWordText.isSecureTextEntry.toggle()
            self.blindRepassWord.setImage(self.rePassWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)
        }).disposed(by: disposeBag)

        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if self.present {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }

    func bindingViewModels() {
        let input = SignUpViewModel.Input(actionRegist: registerButton.rx.tap.map{ [weak self] in
            (self?.userNameText.text ?? "", self?.passWordText.text ?? "")
        })
        let output = viewModel.transfrom(from: input)
        output.registSuccess.drive(onNext: {[weak self] regist in
            UIApplication.shared.hideProgress()
            if regist {
                let vc = RegistSuccessViewController.instantiate { coder in
                    return RegistSuccessViewController(coder: coder)
                }
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "Đăng kí thất bại", message: "Tài khoản hoặc mật khẩu bạn nhập không chính xác", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
