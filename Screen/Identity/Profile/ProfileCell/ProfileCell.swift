//
//  ProfileCell.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 29/04/2023.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(data: (String, AnyHashable)) {
        titleLabel.text = data.0
        contentLabel.text = "\(data.1)"
    }
    
}
