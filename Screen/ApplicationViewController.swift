//
//  ApplicationViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 07/02/2023.
//

import UIKit

class ApplicationViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            APP_DELEGATE?.appNavigator?.start()
        }
    }
}
