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

    private var clockTimer: Timer?
    private var serverDateTime: TimeInterval? = .init()
    public var updateTime = PublishSubject<Void>()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {[weak self] in
               self?.startTime()
        }

        setupViews()
    }

    func setupViews() {
        setupTableView()

        updateTime.subscribe({[weak self]_ in
            self?.accountTableView.reloadData()
        }).disposed(by: disposeBag)
    }

    func startTime() {
        clockTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] (_) in
            guard let self = self, let dateTime = self.serverDateTime else { return }
            self.updateTime.onNext(())
            self.serverDateTime = dateTime + 60
        })
        self.clockTimer?.fire()
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AuthCodeTableViewCell.self, for: indexPath)
        cell.contentView.backgroundColor = .clear
        return cell
    }
}
