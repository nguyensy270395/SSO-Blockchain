//
//  ResetPasswordViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/03/2023.
//

import UIKit

class ResetPasswordViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
