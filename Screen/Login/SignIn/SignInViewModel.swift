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

class SignInViewModel: BaseViewModel, BaseViewModelProtocol {
    struct Input {
        let actionLogin: Observable<(String, String)>
    }

    struct Output {
        let loginSuccess: Driver<Bool>
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
                        loginSuccess.onNext(true)
                        print("Success accessToken: \(data)")
                    }
                case .failure(let error):
                    loginSuccess.onNext(false)
                    print("Fail Query: \(error)")
                }

            }
        }).disposed(by: disposeBag)
        return Output(loginSuccess: loginSuccess.asDriver(onErrorJustReturn: false))
    }

}
