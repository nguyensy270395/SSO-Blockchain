//
//  QRScanViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 05/03/2023.
//

import UIKit
import MercariQRScanner

class QRScanViewController: BaseViewController {

    @IBOutlet weak var qrScanView: QRScannerView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScannerView()
    }

    private func setupQRScannerView() {
        qrScanView.configure(delegate: self, input: .init())
        qrScanView.startRunning()

    }

}

extension QRScanViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
        qrScanView.stopRunning()
    }

    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        qrScanView.stopRunning()
    }
}

