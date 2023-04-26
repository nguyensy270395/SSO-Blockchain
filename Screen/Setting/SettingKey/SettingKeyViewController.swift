//
//  SettingKeyViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 03/04/2023.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class SettingKeyViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @IBOutlet weak var keyTableView: UITableView!
    @IBOutlet weak var newKeyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        keyTableView.delegate = self
        keyTableView.dataSource = self
        keyTableView.registerNib(KeyCell.self)
        keyTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        self.title = "Setting Key"
        isShowBackButton = true
        isShowNavigationBar = true
        setupRx()
    }

    func setupRx() {
        generateButton.rx.tap.subscribe(onNext: { [weak self]_ in
            let vc = GenerateKeyViewController.instantiate { coder in
                return GenerateKeyViewController(coder: coder)
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}

extension SettingKeyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(KeyCell.self, for: indexPath)
        cell.setupKey(keyName: "Key\(indexPath.row + 1)")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
    }
}
