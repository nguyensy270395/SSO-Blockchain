//
//  AppViewModel.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 10/04/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class AppViewModel {
    public var updateTime = PublishSubject<Void>()
    private var clockTimer: Timer?

    init() {
        DispatchQueue.main.async {[weak self] in
            self?.startTime()
        }
    }

    func startTime() {
        var time = 30.0 - Double(Date().second % 30)

        DispatchQueue.main.asyncAfter(deadline: .now() + time) {[weak self] in
            guard let self = self else { return }
            self.clockTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [weak self] (_) in
                guard let self = self else { return }
                let now = Date().second
                self.updateTime.onNext(())
            })
            self.clockTimer?.fire()
        }
    }
}
