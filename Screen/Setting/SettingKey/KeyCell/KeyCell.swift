//
//  KeyCell.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 25/04/2023.
//

import UIKit

class KeyCell: UITableViewCell {

    @IBOutlet weak var checkKey: UIImageView!
    @IBOutlet weak var keyNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        uncheck()
    }

    func uncheck() {
        checkKey.image = nil
        keyNameLabel.textColor = R.color.colorFCFCFC()
    }

    func check() {
        checkKey.image = R.image.iconCheck()
        keyNameLabel.textColor = R.color.color29D112()
    }

    func setupKey(keyName: String) {
        keyNameLabel.text = keyName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            check()
        } else {
            uncheck()
        }
    }
}
