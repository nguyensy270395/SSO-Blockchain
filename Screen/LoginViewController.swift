//
//  LoginViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 07/02/2023.
//

import UIKit

class LoginViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var signInView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()

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
}
