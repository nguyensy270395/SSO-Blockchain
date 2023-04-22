//
//  BiometricViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 03/04/2023.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class BiometricViewController: BaseViewController {

    @IBOutlet weak var biometricSwitch: UISwitch!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting Biometric"
        isShowBackButton = true
        isShowNavigationBar = true
        let value = UserDefaults.standard.bool(forKey: "biometric")
        biometricSwitch.isOn = value
        setupRx()
    }

    func setupRx() {
        biometricSwitch.rx.value.skip(1).subscribe(onNext: {[weak self] value in
            guard let self = self else { return }
            if value {
                self.showCheckPassword()?.subscribe(onNext: {[weak self]check in
                    self?.biometricSwitch.isOn = check
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(biometricSwitch.isOn, forKey: "biometric")
    }
}
