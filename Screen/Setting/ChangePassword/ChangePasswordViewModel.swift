//
//  ChangePasswordViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 27/04/2023.
//

import Foundation

class ChangePasswordViewModel: BaseViewModel, BaseViewModelProtocol {

    let userName = UserDefaults.standard.string(forKey: "user") ?? ""

    struct Input {

    }

    struct Output {

    }

    func transfrom(from input: Input) -> Output {
        Output()
    }

}
