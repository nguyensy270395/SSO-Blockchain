//
//  ApplicationViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 07/02/2023.
//

import UIKit

class ApplicationViewController: BaseViewController {

    var viewModel: ApplicationViewModel!

    required init?(coder: NSCoder, viewModel: ApplicationViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.addDevice()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            APP_DELEGATE?.appNavigator?.start()
        }
    }
}
