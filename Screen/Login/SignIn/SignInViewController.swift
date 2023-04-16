//
//  SignInViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 11/02/2023.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
import LocalAuthentication

class SignInViewController: BaseViewController, BaseViewControllerProtocol {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var blindPassword: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var biometricButton: UIButton!

    var viewModel: SignInViewModel!
    required init?(coder: NSCoder, viewModel: SignInViewModel) {
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

    }

    func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)

        blindPassword.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.passWordText.isSecureTextEntry.toggle()
            self.blindPassword.setImage(self.passWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)

        }).disposed(by: disposeBag)

        registerButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let vc = SignUpViewController.instantiate { coder in
                return SignUpViewController(coder: coder, viewModel: .init())
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)

        forgotPassButton.rx.tap.subscribe(onNext: { [weak self] _ in
            //TODO: forgot password
        }).disposed(by: disposeBag)

        biometricButton.rx.tap.subscribe(onNext: { _ in
            let context = LAContext()
               var error: NSError?

               if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                   let reason = "Identify yourself!"

                   context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                       DispatchQueue.main.async {
                           if success {
                               APP_DELEGATE?.appNavigator?.switchToMain()
                           } else {
                               // error
                           }
                       }
                   }
               } else {
                   // no biometry
               }
        }).disposed(by: disposeBag)

    }

    func bindingViewModels() {
        let input = SignInViewModel.Input(actionLogin: loginButton.rx.tap.map{ [weak self] in
            (self?.userNameText.text ?? "", self?.passWordText.text ?? "")
        })
        let output = viewModel.transfrom(from: input)
        output.loginSuccess.drive(onNext: {[weak self] login in
            UIApplication.shared.hideProgress()
            if login {
                APP_DELEGATE?.appNavigator?.switchToMain()
            } else {
                let alert = UIAlertController(title: "Đăng nhập thất bại", message: "Tài khoản hoặc mật khẩu bạn nhập không chính xác", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }).disposed(by: disposeBag)
    }

}
