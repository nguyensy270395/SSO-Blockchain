//
//  AppNavigator.swift
//  daibet_ios
//
//  Created by duchung on 14/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol AppNavigatorType: class {
    var window: UIWindow? { get }
    func start()
    func switchTo(viewController: UIViewController)
    func handleUrl(url: URL)
}

final class AppNavigator: AppNavigatorType {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let vc = ApplicationViewController.instantiate { coder in
            return ApplicationViewController(coder: coder)
        }
        let nav = UINavigationController(rootViewController: vc)
        switchTo(viewController: nav)
    }
    
    func handleUrl(url: URL) {
    }
    
    func switchTo(viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve],
                          animations: {}, completion: {completed in
        })
    }
}
