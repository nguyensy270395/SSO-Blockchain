//
//  ProofRequestViewController.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 05/05/2023.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ProofRequestViewController: BaseViewController, BaseViewControllerProtocol {

    var viewModel: ProofRequestViewModel!
    @IBOutlet weak var proofTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    @IBAction func shareAction(_ sender: Any) {
        viewModel.checkLogin().subscribe(onNext: {[weak self] bio in
            guard let self = self else { return }
            if bio {
                self.viewModel.callAPI.onNext(())
            } else {
                let checkPass = self.showCheckPassword()
                checkPass.subscribe(onNext: {[weak self]check in
                    if check {
                        self?.viewModel.callAPI.onNext(())
                    }
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: self.disposeBag)
    }
    
    required init?(coder: NSCoder, viewModel: ProofRequestViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViews()
        setupRx()
        bindingViewModels()
    }

    func setupTableView() {
        proofTableView.dataSource = self
        proofTableView.delegate = self
        proofTableView.registerNib(ProofRequestHeader.self)
        proofTableView.registerNib(ProofRequestFooter.self)
        proofTableView.registerNib(ProfileCell.self)
        proofTableView.contentInset = .init(top: 0, left: 0, bottom: 170, right: 0)
    }

    func setupViews() {
    }

    func bindingViewModels() {
        let input = ProofRequestViewModel.Input(actionShare: viewModel.callAPI.asObserver())
        let output = viewModel.transfrom(from: input)
        output.checkDone.drive(onNext: {[weak self]_ in
            let alert = UIAlertController(title: "Xác thực danh tính thành công", message: nil , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {[weak self]_ in
                self?.dismiss(animated: true)
            }))
            self?.present(alert, animated: true)
        }).disposed(by: disposeBag)
    }

    func setupRx() {
        cancelButton.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
}

extension ProofRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberCell
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(ProofRequestHeader.self, for: indexPath)
            return cell
        } else if indexPath.row == (viewModel.numberCell - 1) {
            let cell = tableView.dequeueReusableCell(ProofRequestFooter.self, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(ProfileCell.self, for: indexPath)
            cell.setupProofCell()
            cell.setupCell(data: viewModel.dataAttribute[indexPath.row - 1])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.numberCell - 1) {
            let vc = SelectAtributeViewController.instantiate { coder in
                return SelectAtributeViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
