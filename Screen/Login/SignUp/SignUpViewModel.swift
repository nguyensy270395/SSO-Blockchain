//
//  SignUpViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 15/04/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class SignUpViewModel: BaseViewModel, BaseViewModelProtocol {
    struct Input {
        let actionRegist: Observable<(String, String)>
    }

    struct Output {
        let registSuccess: Driver<Bool>
    }

    func transfrom(from input: Input) -> Output {
        let loginSuccess = PublishSubject<Bool>()
        input.actionRegist.subscribe(onNext: {(userName, passWord) in
            UIApplication.shared.showProgress()
            let data = MySchema.RegisterInput(email: userName, password: passWord)
            ApolloNetwork.shared.apollo.perform(mutation: MySchema.RegisterMutation(data: data)) { result in
                switch result {
                case .success(let queryResult):
                    if let error = queryResult.errors {
                        let message = error.map{ $0.localizedDescription }
                        print("Error: \(message.first)")
                        loginSuccess.onNext(false)
                        return
                    }
                    if let data = queryResult.data?.register.accessToken {
                        UserDefaults.standard.set(data, forKey: "token")
                        UserDefaults.standard.set(userName, forKey: "user")
                        UserDefaults.standard.set(Date(), forKey: "timeLogin")
                        print("Success accessToken: \(data)")
                        loginSuccess.onNext(true)
                    }
                case .failure(let error):
                    loginSuccess.onNext(false)
                    print("Fail Query: \(error)")
                }

            }
        }).disposed(by: disposeBag)
        return Output(registSuccess: loginSuccess.asDriver(onErrorJustReturn: false))
    }

}
