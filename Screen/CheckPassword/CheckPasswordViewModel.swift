//
//  CheckPasswordViewModel.swift
//  SSO Blockchain
//
//  Created by Nguyễn Thanh Sỹ on 20/04/2023.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class CheckPasswordViewModel: BaseViewModel, BaseViewModelProtocol {

    struct Input {
        let actionCheckPass: Observable<String>
    }

    struct Output {
        let checkSuccess: Driver<Bool>
    }


    func transfrom(from input: Input) -> Output {
        let loginSuccess = PublishSubject<Bool>()
        input.actionCheckPass.subscribe(onNext: {passWord in
            UIApplication.shared.showProgress()
            let user = UserDefaults.standard.string(forKey: "user") ?? ""
            let data = MySchema.LoginInput(email: user, password: passWord)
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
                        loginSuccess.onNext(true)
                    }
                case .failure(let error):
                    loginSuccess.onNext(false)
                    print("Fail Query: \(error)")
                }

            }
        }).disposed(by: disposeBag)
        return Output(checkSuccess: loginSuccess.asDriver(onErrorJustReturn: false))
    }

}
