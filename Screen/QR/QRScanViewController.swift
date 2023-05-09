//
//  QRScanViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 05/03/2023.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
import SnapKit

class QRScanViewController: BaseViewController, BaseViewControllerProtocol {

    var viewModel: QRScanViewModel!

    @IBOutlet weak var qrScanView: QRScannerView!
    let messageFromQr = PublishRelay<String>()

    required init?(coder: NSCoder, viewModel: QRScanViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScannerView()
        setupViews()
        setupRx()
        bindingViewModels()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrScanView.startRunning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        qrScanView.stopRunning()
    }
    private func setupQRScannerView() {
        qrScanView.configure(delegate: self, input: .init())
    }

    func setupRx() {
        //        messageFromQr.subscribe(onNext: { text in
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //                QRScanView.shared.show { [weak self] action in
        //                    if action == .close {
        //                        self?.qrScanView.rescan()
        //                    }
        //                }
        //                let vc = ProofRequestViewController.instantiate { coder in
        //                    return ProofRequestViewController(coder: coder, viewModel: .init())
        //                }
        //                self.present(vc, animated: true)
        //            }
        //        }).disposed(by: disposeBag)
    }

    func setupViews() {

    }

    func bindingViewModels() {
        let input = QRScanViewModel.Input(qrLink: messageFromQr.asObservable())
        let output = viewModel.transfrom(from: input)
        output.checkDone.drive(onNext: {[weak self] check in
            UIApplication.shared.hideProgress()
            guard let self = self else { return }
            if check {
                let vc = ProofRequestViewController.instantiate { coder in
                    return ProofRequestViewController(coder: coder, viewModel: .init())
                }
                let vc2 = SelectAtributeViewController.instantiate { coder in
                    return SelectAtributeViewController(coder: coder)
                }
                let nv = CustomNavigation(rootViewController: vc)
                vc.navigationController?.pushViewController(vc2, animated: false)
                nv.callback.subscribe(onNext: {_ in
                    self.qrScanView.startRunning()
                    if let subView = self.qrScanView.viewWithTag(100) {
                        subView.removeFromSuperview()
                    }
                }).disposed(by: self.disposeBag)
                self.present(nv, animated: true)

            } else {
                let messageSignout = "Vui lòng quét lại mã hoặc thử lại bằng mã QR khác"
                let alert = UIAlertController(title: "Quét QR không thành công", message: messageSignout, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction) -> Void in
                    self.dismiss(animated: true, completion: nil)
                    self.qrScanView.startRunning()
                    if let subView = self.qrScanView.viewWithTag(100) {
                        subView.removeFromSuperview()
                    }
                }))

                self.present(alert, animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
}

extension QRScanViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print("QR Error: \(error)")
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print("QRcode: \(code)")
        qrScanView.stopRunning()
        let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.tag = 100
        qrScanView.addSubview(blackView)
        blackView.snp.makeConstraints { cons in
            cons.bottom.equalToSuperview()
            cons.top.equalToSuperview()
            cons.leading.equalToSuperview()
            cons.trailing.equalToSuperview()
        }
        UIApplication.shared.showProgress()
        messageFromQr.accept(code)
    }
}

class CustomNavigation: UINavigationController {
    var callback = PublishSubject<Void>()

    override func viewDidDisappear(_ animated: Bool) {
        callback.onNext(())
    }
}
