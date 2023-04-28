//
//  SettingViewController.swift
//  BaseSwift
//
//  Created by Nguyễn Thanh Sỹ on 15/03/2023.
//

import UIKit

class SettingViewController: BaseTableViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingCase(rawValue: indexPath.row) {
        case .settingKey:
            let vc = SettingKeyViewController.instantiate { coder in
                return SettingKeyViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .biometric:
            let vc = BiometricViewController.instantiate { coder in
                return BiometricViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .resetPassword:
            let vc = ChangePasswordViewController.instantiate { coder in
                return ChangePasswordViewController(coder: coder, viewModel: .init() )
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .information:
            let vc = InformationViewController.instantiate { coder in
                return InformationViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .logout:
            showSignoutMessage()
        default:
            break
        }
    }

    func showSignoutMessage() {
        let messageSignout = "Toàn bộ dữ liệu OTP key của bạn sẽ bị xoá khi bạn đăng xuất khỏi ứng dụng.\nBạn có muốn đăng xuất khỏi SSO-Blockchain?"
        let alert = UIAlertController(title: "Đăng xuất", message: messageSignout, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) -> Void in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            APP_DELEGATE?.appNavigator?.start()
        }))

        present(alert, animated: true, completion: nil)
    }
}

public enum SettingCase: Int {
    case settingKey = 0
    case biometric
    case resetPassword
    case information
    case logout
}
