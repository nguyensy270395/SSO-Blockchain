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
        setupCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setupTimeView()
        setupCell()
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
        animationView?.animationSpeed = 1
    }

    func setupCell() {
        animationView?.loopMode = .playOnce
        var frame = (Double(Date().second % 30) / 30.0) * (animationView?.animation?.endFrame ?? 0)
        animationView?.play(fromFrame: frame, toFrame: animationView?.animation?.endFrame ?? 0)
        guard let data = base32DecodeToData("MABMMELHGEYSQ4TM") else { return }
        if let hotp = TOTP(secret: data, digits: 6) {
            otpLabel.text = hotp.generate(secondsPast1970: Int(Date().timeIntervalSince1970))
        }
    }
}
