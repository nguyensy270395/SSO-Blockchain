//
//  QRScanView.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 28/02/2023.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxRelay

enum ViewAction {
    case close
    case accept
}

class QRScanView: BaseView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var hidenButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!

    static let shared = QRScanView()
    var completion: ((ViewAction) -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
    }

    private func initXib() {
        fromNib()

        hidenButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.hide()
            self.completion?(.close)
        }).disposed(by: disposeBag)

        acceptButton.rx.tap.subscribe(onNext: {  [weak self] _ in
            guard let self = self else { return }
            self.hide()
            self.completion?(.accept)
        }).disposed(by: disposeBag)

    }

    func hide() {
        self.backgroundColor = .clear
        self.hideWithAnimationToBottom(animatedView: self.contentView, callback: nil)
    }

    func show(completion: ((ViewAction) -> Void)? = nil) {
        self.completion = completion
        self.showWithAnimationFromBottom(animatedView: self.contentView, in: nil)
    }
}
