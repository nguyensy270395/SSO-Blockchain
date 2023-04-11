//
//  SettingKeyViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 03/04/2023.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class SettingKeyViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @IBOutlet weak var newKeyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting Key"
        isShowBackButton = true
        isShowNavigationBar = true
        setupRx()
    }

    func setupRx() {
        generateButton.rx.tap.subscribe(onNext: { [weak self]_ in
            let vc = GenerateKeyViewController.instantiate { coder in
                return GenerateKeyViewController(coder: coder)
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}
