//
//  ChangePasswordViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/03/2023.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Password"
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
