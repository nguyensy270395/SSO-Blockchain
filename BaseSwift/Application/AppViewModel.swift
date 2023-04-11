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
    private var serverDateTime: TimeInterval?

    init() {
        DispatchQueue.main.async {[weak self] in
               self?.startTime()
        }
    }

    func startTime() {
        clockTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            guard let self = self, let dateTime = self.serverDateTime else { return }
            self.updateTime.onNext(())
            self.serverDateTime = dateTime + 1
        })
        self.clockTimer?.fire()
    }
}
