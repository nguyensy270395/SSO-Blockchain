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

class QRScanViewController: BaseViewController {

    @IBOutlet weak var qrScanView: QRScannerView!
    let messageFromQr = PublishRelay<String>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScannerView()
        setupRx()
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
        messageFromQr.subscribe(onNext: { text in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                QRScanView.shared.show { [weak self] action in
                    if action == .close {
                        self?.qrScanView.rescan()
                    }
                }
            }
        }).disposed(by: disposeBag)
    }

}

extension QRScanViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
        messageFromQr.accept("error")

    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        messageFromQr.accept(code)

    }
}

