//
//  RegistSuccessViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 16/04/2023.
//

import UIKit
import Lottie

class RegistSuccessViewController: BaseViewController {

    @IBOutlet weak var animationView: UIView!
    var doneView: LottieAnimationView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDoneView()
        doneView?.play {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                APP_DELEGATE?.appNavigator?.switchToMain()
            }
        }
    }

    func setupDoneView() {
        doneView = LottieAnimationView(name: "success")
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
}
