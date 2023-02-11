//
//  UIButton+Extension.swift
//  gurume_go_ios
//
//  Created by Nguyễn Thanh Sỹ on 06/07/2022.
//

import Foundation
import UIKit

extension UIButton {
    func setTitleWithOutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)
        setTitle(title, for: .normal)
        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
}
