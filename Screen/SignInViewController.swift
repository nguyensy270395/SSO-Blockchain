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
    }

}
