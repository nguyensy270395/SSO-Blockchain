//
//  ChangePasswordViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/03/2023.
//

import UIKit

class ChangePasswordViewController: BaseViewController, BaseViewControllerProtocol {

    var viewModel: ChangePasswordViewModel!

    @IBOutlet weak var userLabel: UILabel!

    required init?(coder: NSCoder, viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Password"
        isShowBackButton = true
        isShowNavigationBar = true
        setupViews()
        setupRx()
        bindingViewModels()
    }

    func setupViews() {
        userLabel.text = viewModel.userName
    }

    func bindingViewModels() {

    }

    func setupRx() {

    }
}
