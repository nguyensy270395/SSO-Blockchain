//
//  IdentityCell.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/03/2023.
//

import UIKit

class IdentityCell: BaseTableViewCell {

    @IBOutlet weak var identityLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var workingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(data: MySchema.CredentialsQuery.Data.Credential) {
        let inputString = data.schema_id
        let arrayString = inputString?.components(separatedBy: ":")
        identityLabel.text = arrayString?[2]
        activeLabel.text = data.referent
        appLabel.text = data.cred_def_id
    }
}
