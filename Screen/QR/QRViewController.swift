//
//  QRViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 27/02/2023.
//

import UIKit
//import MercariQRScanner
import AVFoundation
import RxRelay
import RxSwift
import RxCocoa

class QRViewController: BaseViewController {

    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    let messageFromQr = PublishRelay<String>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scanQR()
        captureSession.startRunning()
        setupRx() 
    }

    func setupRx() {
        messageFromQr.subscribe(onNext: { text in
            QRScanView.shared.show { [weak self] action in
                if action == .close {
                    self?.captureSession.startRunning()
                }
            }
        }).disposed(by: disposeBag)
    }
}

extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {

    func scanQR() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if !response {
                return
            }
        }

        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the camera device")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)

        } catch {
            print(error)
            return
        }

        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)

        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)

        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("No QR code is detected")
            return
        }

        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else { return }

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            if let value = metadataObj.stringValue {
                captureSession.stopRunning()
                messageFromQr.accept(value)
            }
        }
    }
}
