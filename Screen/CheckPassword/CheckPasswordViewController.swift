//
//  CheckPasswordViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 20/04/2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class CheckPasswordViewController: BaseViewController, BaseViewControllerProtocol {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var hidenPassButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!

    var viewModel: CheckPasswordViewModel!
    let passWordCheck = PublishSubject<Bool>()

    required init?(coder: NSCoder, viewModel: CheckPasswordViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
        bindingViewModels()
    }

    func setupViews() {

    }

    func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.dismiss(animated: true)
            self?.passWordCheck.onNext(false)
        }).disposed(by: disposeBag)

        hidenPassButton.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.passWordText.isSecureTextEntry.toggle()
            self.hidenPassButton.setImage(self.passWordText.isSecureTextEntry ? R.image.iconEye() : R.image.iconBlind() , for: .normal)
        }).disposed(by: disposeBag)
    }

    func bindingViewModels() {
        let input = CheckPasswordViewModel.Input(actionCheckPass: doneButton.rx.tap
            .map{[weak self] _ in
                self?.passWordText.text ?? ""
            }.asObservable())
        let output = viewModel.transfrom(from: input)
        output.checkSuccess.drive(onNext: {[weak self] checkPass in
            UIApplication.shared.hideProgress()
            if checkPass {
                self?.passWordCheck.onNext(true)
                self?.dismiss(animated: true)
            } else {
                let alert = UIAlertController(title: "Lỗi xác thực", message: "Mật khẩu bạn nhập không chính xác", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }).disposed(by: disposeBag)
    }
}
