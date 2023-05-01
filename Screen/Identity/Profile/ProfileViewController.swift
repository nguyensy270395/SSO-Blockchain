//
//  ProfileViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 24/04/2023.
//

import UIKit

class ProfileViewController: BaseViewController {

    var data: MySchema.CredentialsQuery.Data.Credential?
    var information: [(String, AnyHashable)] {
        data?.attrs?._dictionary.sorted{$0.key < $1.key}.map{($0.key, $0.value)} ?? []
    }

    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIDLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var informationTableView: UITableView!

    required init?(coder: NSCoder, data: MySchema.CredentialsQuery.Data.Credential) {
        self.data = data
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()


    }

    func setupViews() {
        self.title = "Profile"
        isShowBackButton = true
        isShowNavigationBar = true
        let inputString = data?.schema_id
        let arrayString = inputString?.components(separatedBy: ":")
        profileIDLabel.text = "ID: \(data?.cred_def_id ?? "")"
        dateCreateLabel.isHidden = true
        profileNameLabel.text = arrayString?[2]
    }

    func setupTableView() {
        informationTableView.delegate = self
        informationTableView.dataSource = self
        informationTableView.registerNib(ProfileCell.self)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProfileCell.self, for: indexPath)
        cell.setupCell(data: information[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }
}
