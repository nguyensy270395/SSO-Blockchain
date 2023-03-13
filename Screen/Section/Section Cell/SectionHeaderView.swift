//
//  SectionHeaderView.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 26/02/2023.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupHeader(title: String) {
        headerLabel.text = title
    }

}
