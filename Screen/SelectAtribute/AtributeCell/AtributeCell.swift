//
//  AtributeCell.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 08/05/2023.
//

import UIKit

class AtributeCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var subCellView: UIImageView!

    var isSection: Bool = true
    var indexSection: Int? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        isSection = true
        subCellView.isHidden = true
        contentLabel.text = "Hãy lựa chọn 1 propile tương ứng với yêu cầu"
    }

    func setupProfileCell() {
        isSection = false
        subCellView.isHidden = false
        contentLabel.text = "Content Profile"
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            subCellView.image = R.image.iconActive()
            cellView.borderColor = R.color.color29D112() ?? .green
        } else {
            subCellView.image = R.image.iconDeactive()
            cellView.borderColor = R.color.color283442() ?? .gray
        }
    }

}
