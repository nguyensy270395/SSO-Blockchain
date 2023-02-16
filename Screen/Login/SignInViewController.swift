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

class SignInViewController: BaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)

        registerButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let vc = SignUpViewController.instantiate { coder in
                return SignUpViewController(coder: coder)
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)

        forgotPassButton.rx.tap.subscribe(onNext: { [weak self] _ in
            //TODO: forgot password
        }).disposed(by: disposeBag)

        loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            //TODO: login
        }).disposed(by: disposeBag)

    }

}
