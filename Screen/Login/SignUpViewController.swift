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

class SignUpViewController: BaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var rePassWordText: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    var present: Bool = true
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }

    func setupRx() {
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
}
