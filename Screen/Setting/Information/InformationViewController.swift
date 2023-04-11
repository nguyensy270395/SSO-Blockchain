//
//  InformationViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 11/04/2023.
//

import UIKit

class InformationViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SSO-Blockchain"
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
