//
//  SectionTableViewCell.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/02/2023.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var activeView: UIStackView!
    @IBOutlet weak var lastUseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(activeCell: Bool) {
        activeView.isHidden = !activeCell
        lastUseLabel.isHidden = activeCell
        logoutView.isHidden = !activeCell
    }
    
}
