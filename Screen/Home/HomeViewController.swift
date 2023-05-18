//
//  HomeViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 15/02/2023.
//

import UIKit
import RxRelay
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {

    @IBOutlet weak var accountTableView: UITableView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        setupTableView()
        APP_DELEGATE?.appViewModel?.updateTime.subscribe({[weak self]_ in
            self?.accountTableView.reloadData()
        }).disposed(by: disposeBag)
    }

    func setupTableView() {
        accountTableView.delegate = self
        accountTableView.dataSource = self
        accountTableView.registerNib(AuthCodeTableViewCell.self)
        accountTableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AuthCodeTableViewCell.self, for: indexPath)
        cell.contentView.backgroundColor = .clear
        return cell
    }
}
