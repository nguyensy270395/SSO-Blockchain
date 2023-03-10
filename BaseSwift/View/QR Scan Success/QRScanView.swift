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
import Lottie

enum ViewAction {
    case close
    case accept
}

class QRScanView: BaseView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var hidenButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var animationView: UIView!

    var doneView: LottieAnimationView?

    static let shared = QRScanView()
    var completion: ((ViewAction) -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        initXib()
        setupDoneView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initXib()
    }

    func setupDoneView() {
        doneView = LottieAnimationView(name: "done")
        animationView.addSubview(doneView ?? UIView())
        doneView?.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview()
        }
        doneView?.contentMode = .scaleAspectFit
        doneView?.loopMode = .playOnce
        doneView?.animationSpeed = 1
    }

    private func initXib() {
        fromNib()

        hidenButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.hide()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.completion?(.close)
            }
        }).disposed(by: disposeBag)

        acceptButton.rx.tap.subscribe(onNext: {  [weak self] _ in
            guard let self = self else { return }
            self.doneView?.play {_ in
                self.hide()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.completion?(.accept)
            }
        }).disposed(by: disposeBag)

    }

    func hide() {
        self.backgroundColor = .clear
        doneView?.removeFromSuperview()
        self.hideWithAnimationToBottom(animatedView: self.contentView, callback: nil)
    }

    func show(completion: ((ViewAction) -> Void)? = nil) {
        self.completion = completion
        self.setupDoneView()
        self.showWithAnimationFromBottom(animatedView: self.contentView, in: nil)
    }
}
