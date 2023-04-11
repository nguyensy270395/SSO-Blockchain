//
//  AuthCodeTableViewCell.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 16/02/2023.
//

import UIKit
import Lottie
import SwiftOTP

class AuthCodeTableViewCell: BaseTableViewCell {

    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var qrButton: UIButton!
    var animationView: LottieAnimationView?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTimeView()
        setupOTP()
    }

    func setupTimeView() {
        animationView = LottieAnimationView(name: "time")
        timeView.addSubview(animationView ?? UIView())
        animationView?.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview()
        }
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.play()
    }

    func setupOTP() {
        guard let data = base32DecodeToData("ABCDEFGHIJKLMNOP") else { return }

        if let hotp = HOTP(secret: data) {
            otpLabel.text = hotp.generate(counter: 60)
        }
    }
}
