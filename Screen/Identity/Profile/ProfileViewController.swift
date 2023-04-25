//
//  ProfileViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 24/04/2023.
//

import UIKit

class ProfileViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
