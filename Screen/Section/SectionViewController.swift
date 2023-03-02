//
//  SectionViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/02/2023.
//

import UIKit
import Rswift
import SnapKit

class SectionViewController: BaseViewController {

    @IBOutlet weak var sectionTableView: UITableView!

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
        sectionTableView.delegate = self
        sectionTableView.dataSource = self
        sectionTableView.registerNib(SectionTableViewCell.self)
        sectionTableView.registerHeaderFooterNib(SectionHeaderView.self)
        sectionTableView.tableFooterView = nil
    }
}

extension SectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SectionTableViewCell.self, for: indexPath)
        cell.setupCell(activeCell: indexPath.row % 3 == 0)

        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooter(withType: SectionHeaderView.self)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
}
