//
//  BiometricViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 03/04/2023.
//

import UIKit

class BiometricViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting Biometric"
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
