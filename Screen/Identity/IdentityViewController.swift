//
//  IdentityViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 12/03/2023.
//

import UIKit
import Rswift
import SnapKit

class IdentityViewController: BaseViewController, BaseViewControllerProtocol{

    var viewModel: IdentityViewModel!

    @IBOutlet weak var indentityTableView: UITableView!

    required init?(coder: NSCoder, viewModel: IdentityViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        setupViews()
        bindingViewModels()
    }

    func setupViews() {
        setupTableView()
    }

    func bindingViewModels() {
        let input = IdentityViewModel.Input(getData: self.rx.viewWillAppear.asObservable())
        let output = viewModel.transfrom(from: input)
        output.updateData.drive(onNext: {[weak self] data in
            if data {
                self?.indentityTableView.reloadData()
            }

        }).disposed(by: disposeBag)
    }

    func setupRx() {

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
        return viewModel.credentialData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(IdentityCell.self, for: indexPath)
        cell.contentView.backgroundColor = .clear
        cell.setupCell(data: viewModel.credentialData[indexPath.row])
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
        let vc = ProfileViewController.instantiate {[weak self] coder in
            return ProfileViewController(coder: coder, data: (self?.viewModel.credentialData[indexPath.row])!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
