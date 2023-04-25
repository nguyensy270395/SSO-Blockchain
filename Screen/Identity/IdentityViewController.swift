//
//  IdentityViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/03/2023.
//

import UIKit
import Rswift
import SnapKit

class IdentityViewController: BaseViewController {


    @IBOutlet weak var indentityTableView: UITableView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        setupTableView()
    }

    func setupTableView() {
        indentityTableView.delegate = self
        indentityTableView.dataSource = self
        indentityTableView.registerNib(IdentityCell.self)
        indentityTableView.registerHeaderFooterNib(SectionHeaderView.self)
        indentityTableView.tableFooterView = nil
    }
}

extension IdentityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(IdentityCell.self, for: indexPath)
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooter(withType: SectionHeaderView.self)
        header.setupHeader(title: "Identity")
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileViewController.instantiate { coder in
            return ProfileViewController(coder: coder)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
