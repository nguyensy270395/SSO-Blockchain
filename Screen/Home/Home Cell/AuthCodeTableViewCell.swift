//
//  AuthCodeTableViewCell.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 16/02/2023.
//

import UIKit
import Lottie

class AuthCodeTableViewCell: BaseTableViewCell {

    @IBOutlet weak var timeView: UIView!
    var animationView: LottieAnimationView?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTimeView()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
//        animationView?
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        animationView?.play()
    }
}
