//
//  SectionViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 21/02/2023.
//

import UIKit
import Rswift

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
        sectionTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

extension SectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SectionTableViewCell.self, for: indexPath)
        cell.setupCell(activeCell: indexPath.row % 2 == 0)
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        label.text = "Section"
        label.textColor = .black
        label.font = R.font.nunitoBold(size: 21)
        headerView.addSubview(label)
        label.snp
        return headerView
    }
}
