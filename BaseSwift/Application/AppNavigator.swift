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
    func switchToMain()
    func handleUrl(url: URL)
    func loadFirstView()
}

final class AppNavigator: AppNavigatorType {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if let timeLogin = UserDefaults.standard.object(forKey: "timeLogin") as? Date {
            if timeLogin.add(minutes: 0) > Date() {
                switchToMain()
            } else {
                let vc = SignInViewController.instantiate { coder in
                    return SignInViewController(coder: coder, viewModel: .init())
                }
                vc.isShowBackButton = false
                let nav = UINavigationController(rootViewController: vc)
                switchTo(viewController: nav)
            }
            return
        }
        let vc = StartViewController.instantiate { coder in
            return StartViewController(coder: coder)
        }
        let nav = UINavigationController(rootViewController: vc)
        switchTo(viewController: nav)
    }

    func loadFirstView() {
        let vc = ApplicationViewController.instantiate { coder in
            return ApplicationViewController(coder: coder)
        }
        let nav = UINavigationController(rootViewController: vc)
        switchTo(viewController: nav)
    }
    
    func handleUrl(url: URL) {
    }

    func switchToMain() {
        switchTo(viewController: MainTabbarViewController(viewModel: .init()))
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
