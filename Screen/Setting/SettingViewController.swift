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
        self.isShowNavigationBar = false
        title = "Setting"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 21)!, NSAttributedString.Key.foregroundColor: R.color.colorFCFCFC()]

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingCase(rawValue: indexPath.row) {
        case .settingKey: break
        case .biometric:
            let vc = BiometricViewController.instantiate { coder in
                return BiometricViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .resetPassword:
            let vc = ChangePasswordViewController.instantiate { coder in
                return ChangePasswordViewController(coder: coder)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        case .information: break
        case .logout: break
        default:
            break
        }
    }
}

public enum SettingCase: Int {
    case settingKey = 0
    case biometric
    case resetPassword
    case information
    case logout
}
