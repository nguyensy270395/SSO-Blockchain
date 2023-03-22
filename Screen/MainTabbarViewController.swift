//
//  MainTabbarViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 15/02/2023.
//

import UIKit
import RxSwift

class MainTabbarViewController: UITabBarController {

    var viewModel: MainTabbarViewModel!
    private let disposeBag = DisposeBag()

    required init(viewModel: MainTabbarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = TabbarItem.allCases.map { addTab(type: $0) }
        self.tabBar.selectedImageTintColor = R.color.color29606D()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func addTab(type: TabbarItem) -> UIViewController {
        let tabItem = UITabBarItem(title: type.title, image: type.icon, tag: type.rawValue)
        let vc = type.viewController
        vc.tabBarItem = tabItem
        return vc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

enum TabbarItem: Int, CaseIterable {
    case home = 0
    case section
    case qr
    case identity
    case setting

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .section:
            return "Section"
        case .qr:
            return "QR"
        case .identity:
            return "Indentity"
        case .setting:
            return "Setting"
        }
    }

    var icon: UIImage? {
        switch self {
        case .home:
            return R.image.iconBlock()
        case .section:
            return R.image.iconSection()
        case .qr:
            return R.image.iconTabbarQR()
        case .identity:
            return R.image.iconIdentity()
        case .setting:
            return R.image.iconSetting()
        }
    }

    var viewController: UIViewController {
        switch self {
        case .home:
            let vc = HomeViewController.instantiate { coder in
                return HomeViewController(coder: coder)
            }
            return BaseNavigationViewController(rootViewController: vc)
        case .section:
            let vc = SectionViewController.instantiate { coder in
                return SectionViewController(coder: coder)
            }
            return BaseNavigationViewController(rootViewController: vc)
        case .qr:
            let vc = QRScanViewController.instantiate { coder in
                return QRScanViewController(coder: coder)
            }
            return BaseNavigationViewController(rootViewController: vc)
        case .identity:
            let vc = IdentityViewController.instantiate { coder in
                return IdentityViewController(coder: coder)
            }
            return BaseNavigationViewController(rootViewController: vc)
        case .setting:
            let vc = SettingViewController.instantiate { coder in
                return SettingViewController(coder: coder)
            }
            return BaseNavigationViewController(rootViewController: vc)
        }
    }
}
