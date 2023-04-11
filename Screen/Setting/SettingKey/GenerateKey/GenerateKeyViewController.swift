//
//  GenerateKeyViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 04/04/2023.
//

import UIKit

class GenerateKeyViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Generate Key"
        isShowBackButton = true
        isShowNavigationBar = true
    }
}
