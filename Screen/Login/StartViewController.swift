//
//  StartViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 07/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class StartViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupRx()
    }

    func setupAnimation() {
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                       usingSpringWithDamping: 2,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.signInView.center.y = 0
                }, completion: nil)
    }

    func setupRx() {
        signInButton.rx.tap.subscribe(onNext: {[weak self] _ in
            let vc = SignInViewController.instantiate { coder in
                return SignInViewController(coder: coder, viewModel: .init())
            }
            let nav = BaseNavigationViewController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true)
        }).disposed(by: disposeBag)

        signUpButton.rx.tap.subscribe(onNext: {[weak self] _ in
            let vc = SignUpViewController.instantiate { coder in
                return SignUpViewController(coder: coder, viewModel: .init())
            }
            vc.present.toggle()
            let nav = BaseNavigationViewController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true)
        }).disposed(by: disposeBag)

    }
}
