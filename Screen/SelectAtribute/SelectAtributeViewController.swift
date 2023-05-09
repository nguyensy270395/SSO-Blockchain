//
//  SelectAtributeViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 07/05/2023.
//

import UIKit

class SelectAtributeViewController: BaseViewController {
    
    @IBOutlet weak var atributeTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    let arr: [SectionCell] = [.init(), .init(), .init(), .init()]
    var selectSection: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Atribute"
        isShowBackButton = true
        isShowNavigationBar = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 21)!, NSAttributedString.Key.foregroundColor: R.color.color283442()]
        setupTableView()
        setupRx()
    }

    func setupTableView() {
        atributeTableView.dataSource = self
        atributeTableView.delegate = self
        atributeTableView.registerNib(EmployerCell.self)
        atributeTableView.registerNib(AtributeCell.self)
        atributeTableView.contentInset = .init(top: 0, left: 0, bottom: 170, right: 0)
    }

    func setupRx() {
        cancelButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }

}

extension SelectAtributeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectSection = selectSection {
            return arr.count + 1 + (arr[selectSection - 1].array.count)
        } else {
            return arr.count + 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(EmployerCell.self, for: indexPath)
            return cell
        } else {
            if let selectSection = selectSection {
                if (selectSection < indexPath.row) && (indexPath.row <= (selectSection + arr[selectSection - 1].array.count)) {
                    let cell = tableView.dequeueReusableCell(AtributeCell.self, for: indexPath)
                    cell.setupProfileCell()
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(AtributeCell.self, for: indexPath)
                    return cell
                }

            } else {
                let cell = tableView.dequeueReusableCell(AtributeCell.self, for: indexPath)
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)
        if let cell = tableView.cellForRow(at: indexPath) as? AtributeCell {
            if cell.isSection {
                if let selectSection = selectSection, selectSection != indexPath.row {
                    if (indexPath.row - arr[selectSection - 1].array.count) > 0 {
                        self.selectSection = indexPath.row - arr[selectSection - 1].array.count
                    } else {
                        self.selectSection = indexPath.row
                    }
                } else {
                    selectSection = indexPath.row
                }
                atributeTableView.reloadData()
            }
        }
    }
}


struct SectionCell {
    let title: String
    let array: [String]
    init(title: String = "Section", array: [String] = ["1","2","3"]) {
        self.title = title
        self.array = array
    }
}
