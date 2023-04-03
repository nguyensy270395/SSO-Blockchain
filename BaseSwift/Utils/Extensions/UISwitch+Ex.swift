//
//  UISwitch.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 03/04/2023.
//

import UIKit

extension UISwitch {

    static let standardHeight: CGFloat = 31
    static let standardWidth: CGFloat = 51

    @IBInspectable var width: CGFloat {
        set {
            set(width: newValue, height: height)
        }
        get {
            frame.width
        }
    }

    @IBInspectable var height: CGFloat {
        set {
            set(width: width, height: newValue)
        }
        get {
            frame.height
        }
    }

    @IBInspectable var scales: CGFloat {
        set {
            set(width: width, height: height * newValue)
        }
        get {
            frame.height / UISwitch.standardHeight
        }
    }

    @IBInspectable var offTintColor: UIColor {
        set {
            self.tintColor = newValue
            self.layer.cornerRadius = 16
            self.backgroundColor = newValue
        }
        get {
            self.tintColor
        }
    }

    func set(width: CGFloat, height: CGFloat) {

        let heightRatio = height / UISwitch.standardHeight
        let widthRatio = width / UISwitch.standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
