//
//  SignInViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 15/04/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import LocalAuthentication

class SignInViewModel: BaseViewModel, BaseViewModelProtocol {
    let checkToken: Bool = {
        if let token = UserDefaults.standard.string(forKey: "token") {
            return true
        } else {
            return false
        }
    }()

    struct Input {
        let actionLogin: Observable<(String, String)>
        let actionBiometric: Observable<Void>
    }

    struct Output {
        let loginSuccess: Driver<Bool>
    }

    func checkLogin() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        APP_DELEGATE?.appNavigator?.switchToMain()
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometry
        }

    }

    func transfrom(from input: Input) -> Output {
        let loginSuccess = PublishSubject<Bool>()
        input.actionLogin.subscribe(onNext: {(userName, passWord) in
            UIApplication.shared.showProgress()
            let data = MySchema.LoginInput(email: userName, password: passWord)
            ApolloNetwork.shared.apollo.perform(mutation: MySchema.LoginMutation(data: data)) { result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        print("Error: \(message.first)")
                        loginSuccess.onNext(false)
                        return
                    }
                    if let data = queryResult.data?.login.accessToken {
                        UserDefaults.standard.set(data, forKey: "token")
                        UserDefaults.standard.set(Date(), forKey: "timeLogin")
                        loginSuccess.onNext(true)
                        print("Success accessToken: \(data)")
                    }
                case .failure(let error):
                    loginSuccess.onNext(false)
                    print("Fail Query: \(error)")
                }

            }
        }).disposed(by: disposeBag)

        input.actionBiometric.subscribe(onNext: {_ in
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            UserDefaults.standard.set(Date(), forKey: "timeLogin")
                            loginSuccess.onNext(true)
                        }
                    }
                }
            } 
        }).disposed(by: disposeBag)
        return Output(loginSuccess: loginSuccess.asDriver(onErrorJustReturn: false))
    }

}
